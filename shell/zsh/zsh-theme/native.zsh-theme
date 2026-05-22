autoload -U colors && colors

# =========================================
# Symbols
# =========================================

ARROW_RIGHT=""
ARROW_RIGHT_THIN=""
ARROW_LEFT=""
CURVE_BOTTOM="╰"
CENTER_LINE="─"

# =========================================
# Prompt Symbols
# =========================================

PROMPT_SYMS=(
  '( - ω -)つ'
  '(_ ˙꒳˙)_'
  '(∩ ˇ ω ˇ ∩)'
  '(^o^)'
  '(ﾉ･ω ･)ﾉ'
  '(ง˘ω ˘)ว'
  '(；´Д｀)'
  '(=^･ω･^=)'
  '(▼･ω･▼)'
  'c(U*･× ･)U'
  '(♡ > ω < ♡)'
  '(*ˊᗜ ˋ)ﾉﾞ'
)

# =========================================
# Host Color Profiles
# =========================================

set_prompt_palette() {
  case "$HOST" in

    APG-2512*)
      HEAD_C='#80ff80'
      BODY_C1='#8080ff'
      BODY_C2='#80ffff'
      SUCCESS_C='#40cc40'
      FAILED_C='#cc4040'
      ;;

    NCP-2602*)
      HEAD_C='#0000ff'
      BODY_C1='#ffff80'
      BODY_C2='#808040'
      SUCCESS_C='#208020'
      FAILED_C='#ff0000'
      ;;

    FDS-2509*)
      HEAD_C='#ffff80'
      BODY_C1='#ff40ff'
      BODY_C2='#ffc0ff'
      SUCCESS_C='#00ff00'
      FAILED_C='#202020'
      ;;

    DTC-2603*)
      HEAD_C='#ff80ff'
      BODY_C1='#ff0060'
      BODY_C2='#ffa0c0'
      SUCCESS_C='#20dd20'
      FAILED_C='#cc4040'
      ;;

    *)
      HEAD_C='#000000'
      BODY_C1='#ffffff'
      BODY_C2='#808080'
      SUCCESS_C='#40cc40'
      FAILED_C='#cc4040'
      ;;
  esac

}

# =========================================
# Utilities
# =========================================

DISTRO_NAME="$($HOME/Dotfiles/scripts/bin/distro-name)"

random_symbol() {
  echo "${PROMPT_SYMS[RANDOM % $#PROMPT_SYMS + 1]}"
}

segment() {
  local bg="$1"
  local fg="$2"
  local text="$3"

  echo "%K{${bg}}%F{${fg}}${text}%f%k"
}

arrow() {
  local left="$1"
  local right="$2"

  echo "%K{${right}}%F{${left}}${ARROW_RIGHT}%f"
}

# =========================================
# Prompt Builder
# =========================================

build_left_prompt() {
  local sym=$(random_symbol)

  PROMPT+=" ${CURVE_BOTTOM}${CENTER_LINE}" 
  PROMPT+=" %(?.%F{${SUCCESS_C}}O.%F{${FAILED_C}}X)%f"
  PROMPT+=" ${CENTER_LINE}"
  PROMPT+=" ${sym}"
  PROMPT+=" ${CENTER_LINE}${ARROW_RIGHT_THIN} "
}

# =========================================
# Header Line
# =========================================

print_header() {
  print -P ""

  print -P \
"%K{${HEAD_C}} \
%K{${BODY_C1}}%F{${BODY_C2}} %n@%m [${DISTRO_NAME}] \
%K{${BODY_C2}}%F{${BODY_C1}}${ARROW_RIGHT}\
%K{${BODY_C2}}%F{${BODY_C1}} %D %* \
%K{${BODY_C1}}%F{${BODY_C2}}${ARROW_RIGHT}\
%K{${BODY_C1}}%F{${BODY_C2}} %~ \
%K{black}%F{${BODY_C1}}${ARROW_RIGHT}"
}

# =========================================
# precmd
# =========================================

precmd() {
  set_prompt_palette

  PROMPT=""
  RPROMPT=""

  print_header
  build_left_prompt
}
