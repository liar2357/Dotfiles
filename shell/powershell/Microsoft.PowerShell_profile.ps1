# =========================
# Custom Prompt Theme
# =========================

# UTF-8
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# ANSI有効
$PSStyle.OutputRendering = "Ansi"

# -------------------------
# Colors
# -------------------------

$global:HEAD_C    = "#80ff80"
$global:BODY_C1  = "#8080ff"
$global:BODY_C2  = "#80ffff"

$global:SUCCESS_C = "#40cc40"
$global:FAILED_C  = "#cc4040"

# Powerline
$global:ARROW_RIGHT = ""
$global:ARROW_LEFT  = ""

# 顔文字
$global:PROMPT_SYMS = @(
    "( - ω -)つ",
    "(_ ˙꒳˙)_",
    "(∩ ˇ ω ˇ ∩)",
    "(^o^)",
    "(ﾉ･ω ･)ﾉ",
    "(ง˘ω ˘)ว",
    "(；´Д｀)",
    "(=^･ω･^=)",
    "(▼･ω･▼)",
    "c(U*･× ･)U",
    "(♡ > ω < ♡)",
    "(*ˊᗜ ˋ)ﾉﾞ"
)

# -------------------------
# ANSI Helpers
# -------------------------

function FG($c) {
    return "$([char]27)[38;2;$([Convert]::ToInt32($c.Substring(1,2),16));$([Convert]::ToInt32($c.Substring(3,2),16));$([Convert]::ToInt32($c.Substring(5,2),16))m"
}

function BG($c) {
    return "$([char]27)[48;2;$([Convert]::ToInt32($c.Substring(1,2),16));$([Convert]::ToInt32($c.Substring(3,2),16));$([Convert]::ToInt32($c.Substring(5,2),16))m"
}

function RESET() {
    return "$([char]27)[0m"
}

# -------------------------
# Distro Name
# -------------------------

function Get-DistroName {

    if ($IsWindows) {
        return "Windows"
    }

    if (Test-Path "/etc/os-release") {
        $name = (
            Get-Content /etc/os-release |
            Where-Object { $_ -match "^PRETTY_NAME=" } |
            ForEach-Object {
                $_.Split("=")[1].Trim('"')
            }
        )

        if ($name) {
            return $name
        }
    }

    return "Unknown"
}

# -------------------------
# Prompt
# -------------------------

function global:prompt {

    $head  = BG($HEAD_C)
    $body1 = BG($BODY_C1)
    $body2fg = FG($BODY_C2)

    $body1fg = FG($BODY_C1)
    $headfg  = FG($HEAD_C)

    $reset = RESET()

    $user = [Environment]::UserName
    $hostn = $env:COMPUTERNAME

    $distro = Get-DistroName

    $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

    $path = (Get-Location).Path

    # HOME短縮
    $path = $path.Replace($HOME, "~")

    # 前回終了コード
    $success = $?

    if ($success) {
        $statusText = "$(FG $SUCCESS_C)○ SUCCESS"
    }
    else {
        $statusText = "$(FG $FAILED_C)✘ FAILED"
    }

    # ランダム顔文字
    $sym = Get-Random $PROMPT_SYMS

    # 上段
    Write-Host ""

    Write-Host -NoNewline (
        "$(BG $HEAD_C) " +
        "$(BG $BODY_C1)$(FG $BODY_C2) $user@$hostn [$distro] " +
        "$(BG $BODY_C2)$(FG $BODY_C1)$ARROW_RIGHT" +
        "$(FG $BODY_C1) $date " +
        "$(BG $BODY_C1)$(FG $BODY_C2)$ARROW_RIGHT" +
        "$(FG $HEAD_C) $path " +
        "$(BG '000000')$(FG $BODY_C1)$ARROW_RIGHT" +
        "$reset"
    )

    Write-Host ""

    # 左Prompt
    Write-Host -NoNewline (
        "$(BG $HEAD_C) " +
        "$(BG $BODY_C1)$(FG $BODY_C2) $sym " +
        "$reset$(FG $BODY_C1)$ARROW_RIGHT$reset "
    )

    # 右側Status
    $width = $Host.UI.RawUI.WindowSize.Width

    $right = " $statusText $reset"

    $cursor = $Host.UI.RawUI.CursorPosition.X

    $padding = $width - $cursor - 20

    if ($padding -gt 1) {
        Write-Host -NoNewline (" " * $padding)
        Write-Host -NoNewline (
            "$(FG $BODY_C1)$ARROW_LEFT" +
            "$(BG $BODY_C1) $right $(BG $HEAD_C) $reset"
        )
    }

    return " "
}
