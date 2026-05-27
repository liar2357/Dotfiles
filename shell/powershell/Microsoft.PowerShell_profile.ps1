# =========================================
# Requirements
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

    if ($env:CONTAINER_ID) {

        $global:HEAD_C    = HEX "#008080"
        $global:BODY_C1   = HEX "#80ff80"
        $global:BODY_C2   = HEX "#008000"
        $global:SUCCESS_C = HEX "#0000ff"
        $global:FAILED_C  = HEX "#ff0000"

        $global:MODE_FLG = "DistroBox"
    }
    elseif ($NestedPromptLevel -gt 0) {

        $global:HEAD_C    = HEX "#000000"
        $global:BODY_C1   = HEX "#ffffff"
        $global:BODY_C2   = HEX "#808080"
        $global:SUCCESS_C = HEX "#40cc40"
        $global:FAILED_C  = HEX "#cc4040"

        $global:MODE_FLG = "SubShell"
    }
    else {

        switch -Wildcard ($env:COMPUTERNAME) {

            "APG-2512*" {
                $global:HEAD_C    = HEX "#80ff80"
                $global:BODY_C1   = HEX "#8080ff"
                $global:BODY_C2   = HEX "#80ffff"
                $global:SUCCESS_C = HEX "#40cc40"
                $global:FAILED_C  = HEX "#cc4040"
            }

            "NCP-2602*" {
                $global:HEAD_C    = HEX "#0000ff"
                $global:BODY_C1   = HEX "#ffff80"
                $global:BODY_C2   = HEX "#808040"
                $global:SUCCESS_C = HEX "#208020"
                $global:FAILED_C  = HEX "#ff0000"
            }

            "FDS-2509*" {
                $global:HEAD_C    = HEX "#ffff80"
                $global:BODY_C1   = HEX "#ff40ff"
                $global:BODY_C2   = HEX "#ffc0ff"
                $global:SUCCESS_C = HEX "#00ff00"
                $global:FAILED_C  = HEX "#202020"
            }

            "DTC-2603*" {
                $global:HEAD_C    = HEX "#ff80ff"
                $global:BODY_C1   = HEX "#ff0060"
                $global:BODY_C2   = HEX "#ffa0c0"
                $global:SUCCESS_C = HEX "#20dd20"
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

    return " [$branch$flags]"
}

# =========================================
# Distro Name
# =========================================

function Get-DistroName {

    if ($IsWindows) {
        return "Windows"
    }

    return "PowerShell"
}

# =========================================
# Prompt
# =========================================

function prompt {

    $lastExit = $LASTEXITCODE

    Set-PromptPalette

    $sym = Get-Random $PROMPT_SYMS

    $distro = Get-DistroName

    switch ($MODE_FLG) {

        "DistroBox" {
            $place = "$distro on DistroBox Lv.$NestedPromptLevel"
        }

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
        if ($lastExit -eq 0) {
            "$(FG $SUCCESS_C)"
        }
        else {
            "$(FG $FAILED_C)"
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
        "$(FG $BODY_C1)$CENTER_LINE $sym $CENTER_LINE $ARROW_RIGHT_THIN " +
        "$RESET"
    ) -NoNewline

    return " "
}
