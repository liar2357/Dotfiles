# =========================
# Custom Prompt Theme
# =========================

[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$PSStyle.OutputRendering = "Ansi"

# -------------------------
# Colors
# -------------------------

$global:HEAD_C     = "#80ff80"
$global:BODY_C1    = "#8080ff"
$global:BODY_C2    = "#80ffff"

$global:SUCCESS_C  = "#40cc40"
$global:FAILED_C   = "#cc4040"

$global:ARROW_RIGHT = ""
$global:ARROW_LEFT  = ""

# -------------------------
# Prompt Symbols
# -------------------------

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

function FG($hex) {

    $r = [Convert]::ToInt32($hex.Substring(1,2),16)
    $g = [Convert]::ToInt32($hex.Substring(3,2),16)
    $b = [Convert]::ToInt32($hex.Substring(5,2),16)

    return "$([char]27)[38;2;${r};${g};${b}m"
}

function BG($hex) {

    $r = [Convert]::ToInt32($hex.Substring(1,2),16)
    $g = [Convert]::ToInt32($hex.Substring(3,2),16)
    $b = [Convert]::ToInt32($hex.Substring(5,2),16)

    return "$([char]27)[48;2;${r};${g};${b}m"
}

function RESET {

    return "$([char]27)[0m"
}

# -------------------------
# Distro Name
# -------------------------

function Get-DistroName {

    if ($IsWindows) {
        return "Windows11"
    }

    return "Unknown"
}

# -------------------------
# Prompt
# -------------------------

function global:prompt {

    try {

        $reset = RESET

        $user = [Environment]::UserName
        $hostn = $env:COMPUTERNAME

        $distro = Get-DistroName

        $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"

        $path = (Get-Location).Path.Replace($HOME, "~")

        # 成功判定
        $ok = $?

        if ($ok) {
            $statusText = "$(FG $SUCCESS_C)O"
        }
        else {
            $statusText = "$(FG $FAILED_C)X"
        }

        # 顔文字
        $sym = Get-Random $PROMPT_SYMS

        Write-Host ""

        # 上段
        Write-Host -NoNewline (
            "$(BG $HEAD_C) " +
            "$(BG $BODY_C1)$(FG $BODY_C2) $user@$hostn [$distro] " +
            "$(BG $BODY_C2)$(FG $BODY_C1)$ARROW_RIGHT" +
            "$(FG $BODY_C1) $date " +
            "$(BG $BODY_C1)$(FG $BODY_C2)$ARROW_RIGHT" +
            "$(FG $HEAD_C) $path " +
            "$(BG '#000000')$(FG $BODY_C1)$ARROW_RIGHT" +
            "$reset"
        )

        Write-Host ""

        # 下段
        Write-Host -NoNewline (
            "$(BG $HEAD_C) " +
            "$(BG $BODY_C1)$(FG $BODY_C2) $statusText " +
	    "$(BG $BODY_C2)$(FG $BODY_C1)$ARROW_RIGHT" +
	    "$(BG $BODY_C2)$(FG $BODY_C1) $sym " + 
	    "$(BG '#000000')$(FG $BODY_C2)$ARROW_RIGHT" +
	    "$reset"
        )

        return " "
    }
    catch {

        Write-Host $_ -ForegroundColor Red

        return "PS> "
    }
}
