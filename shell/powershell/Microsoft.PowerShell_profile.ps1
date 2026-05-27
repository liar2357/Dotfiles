# =======================================# Requirements
# =========================================

Import-Module posh-git -ErrorAction SilentlyContinue

$PSStyle.OutputRendering = "Ansi"

# =========================================
# Symbols
# =========================================

$ARROW_RIGHT      = ""
$ARROW_RIGHT_THIN = ""

$CURVE_TOP    = "╭"
$CURVE_BOTTOM = "╰"
$CENTER_LINE  = "─"

# =========================================
# Prompt Symbols
# =========================================

$PROMPT_SYMS = @(
  ' ( - ω -)つ'
  ' (_ ˙꒳˙)_ '
  '(∩ ˇ ω ˇ ∩)'
  '   (^o^)   '
  '  (ﾉ･ω ･)ﾉ '
  '  (ง˘ω ˘)ว '
  '  (；´Д｀) '
  ' (=^･ω･^=) '
  '  (▼･ω･▼)  '
  ' c(U*･× ･)U'
  '(♡ > ω < ♡)'
  '  (*ˊᗜ ˋ)ﾉﾞ '
)

# =========================================
# ANSI Helper
# =========================================

function FG($c) {
    return "$([char]27)[38;2;$($c.R);$($c.G);$($c.B)m"
}

function BG($c) {
    return "$([char]27)[48;2;$($c.R);$($c.G);$($c.B)m"
}

function HEX($hex) {
    $hex = $hex.TrimStart('#')

    [PSCustomObject]@{
        R = [Convert]::ToInt32($hex.Substring(0,2),16)
        G = [Convert]::ToInt32($hex.Substring(2,2),16)
        B = [Convert]::ToInt32($hex.Substring(4,2),16)
    }
}

$RESET = "$([char]27)[0m"

# =========================================
# Palette
# =========================================

function Set-PromptPalette {

    $global:MODE_FLG = "Normal"

    if ($NestedPromptLevel -gt 0) {

        $global:HEAD_C    = HEX "#000000"
        $global:BODY_C1   = HEX "#ffffff"
        $global:BODY_C2   = HEX "#808080"
        $global:SUCCESS_C = HEX "#40cc40"
        $global:FAILED_C  = HEX "#cc4040"

        $global:MODE_FLG = "SubShell"
    }
    else {

        switch -Wildcard ($env:COMPUTERNAME) {

            "WDG-2011*" {
                $global:HEAD_C    = HEX "#ff0000"
                $global:BODY_C1   = HEX "#ff8080"
                $global:BODY_C2   = HEX "#804040"
                $global:SUCCESS_C = HEX "#40cc40"
                $global:FAILED_C  = HEX "#cc4040"
            }

            "WLG-2403*" {
                $global:HEAD_C    = HEX "#00ff00"
                $global:BODY_C1   = HEX "#408040"
                $global:BODY_C2   = HEX "#80ff80"
                $global:SUCCESS_C = HEX "#40cc40"
                $global:FAILED_C  = HEX "#cc4040"
            }

            "WVS-2604*" {
                $global:HEAD_C    = HEX "#8080ff"
                $global:BODY_C1   = HEX "#80ffff"
                $global:BODY_C2   = HEX "#0000ff"
                $global:SUCCESS_C = HEX "#40cc40"
                $global:FAILED_C  = HEX "#cc4040"
            }

            default {
                $global:HEAD_C    = HEX "#000000"
                $global:BODY_C1   = HEX "#ffffff"
                $global:BODY_C2   = HEX "#808080"
                $global:SUCCESS_C = HEX "#40cc40"
                $global:FAILED_C  = HEX "#cc4040"
            }
        }
    }
}

# =========================================
# Git Info
# =========================================

function Get-GitSegment {

    $branch = git branch --show-current 2>$null

    if (-not $branch) {
        return ""
    }

    $status = git status --porcelain 2>$null

    $staged = $false
    $unstaged = $false

    foreach ($line in $status) {

        if ($line.Substring(0,1) -ne " ") {
            $staged = $true
        }

        if ($line.Substring(1,1) -ne " ") {
            $unstaged = $true
        }
    }

    $flags = ""

    if ($staged) {
        $flags += "+"
    }

    if ($unstaged) {
        $flags += "*"
    }

    return " $CENTER_LINE [$branch$flags]"
}

# =========================================
# Distro Name
# =========================================

function Get-DistroName {

    if ($IsWindows) {

        $os = Get-CimInstance Win32_OperatingSystem

        # "Microsoft Windows 11 Home"
        # -> "Windows 11 Home"
        $caption = (
            $os.Caption.Trim() `
                -replace '^Microsoft\s+', ''
        )

        $cv = Get-ItemProperty `
            "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

        $release =
            if ($cv.DisplayVersion) {
                $cv.DisplayVersion
            }
            elseif ($cv.ReleaseId) {
                $cv.ReleaseId
            }
            else {
                ""
            }

        # ARM64対応込み
        $arch = switch (
            [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
        ) {

            "X64"   { "x86_64" }
            "X86"   { "x86" }
            "Arm64" { "aarch64" }
            "Arm"   { "arm" }

            default {
                $_.ToString().ToLower()
            }
        }

        return "$caption ($release) $arch"
    }

    return "PowerShell"
}

# =========================================
# Prompt
# =========================================

function prompt {

    $lastSuccess = $?

    Set-PromptPalette

    $sym = Get-Random $PROMPT_SYMS

    $distro = Get-DistroName

    switch ($MODE_FLG) {

        "SubShell" {

            if ($env:NVIM) {
                $place = "NVIM"
            }
            elseif ($env:IN_NIX_SHELL) {
                $place = "NIX"
            }
            elseif ($env:TMUX) {
                $place = "TMUX"
            }
            else {
                $place = "SUB"
            }

            $place += " Lv.$NestedPromptLevel"
        }

        default {
            $place = $distro
        }
    }

    $git = Get-GitSegment

    $successIcon =
        if ($lastSuccess) {
            "$(FG $SUCCESS_C) "
        }
        else {
            "$(FG $FAILED_C) "
        }

    $path = $executionContext.SessionState.Path.CurrentLocation

    Write-Host ""

    # Header
    Write-Host (
        "$(BG $HEAD_C) " +
        "$(BG $BODY_C1)$(FG $BODY_C2) $env:USERNAME@$env:COMPUTERNAME [$place] " +
        "$(BG $BODY_C2)$(FG $BODY_C1)$ARROW_RIGHT" +
        "$(BG $BODY_C2)$(FG $BODY_C1) pwsh $($PSVersionTable.PSVersion.ToString()) " +
        "$RESET$(FG $BODY_C2)$ARROW_RIGHT$RESET"
    ) -NoNewline

    Write-Host ""

    # Middle
    Write-Host (
        "$(FG $BODY_C1) " +
        "$CURVE_TOP$CENTER_LINE " +
        "$path" +
        "$git" +
        "$RESET"
    )

    # Bottom
    Write-Host (
        "$(FG $BODY_C1) " +
        "$CURVE_BOTTOM$CENTER_LINE " +
        "$successIcon " +
        "$(FG $BODY_C1)$CENTER_LINE $sym $CENTER_LINE$ARROW_RIGHT_THIN " +
        "$RESET"
    ) -NoNewline

    return " "
}


# =========================================
# Link Config Files
# =========================================

. "$HOME\Dotfiles\shell\COMMON\alias-and-function.ps1"
