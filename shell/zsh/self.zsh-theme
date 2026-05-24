autoload -U colors && colors

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

# staged
zstyle ':vcs_info:*' stagedstr '+'

# unstaged
zstyle ':vcs_info:*' unstagedstr '*'

# branch format
zstyle ':vcs_info:git:*' formats '%F{${BODY_C1}}[%b%c%u]%f'

# merge/rebase etc
zstyle ':vcs_info:git:*' actionformats '%F{${FAILED_C}}[%b|%a]%f'

# =========================================
# Symbols
# =========================================

ARROW_RIGHT=""
ARROW_RIGHT_THIN=""
ARROW_LEFT=""
CURVE_TOP="╭"
CURVE_BOTTOM="╰"
CENTER_LINE="─"

# =========================================
# Prompt Symbols
# =========================================

PROMPT_SYMS=(
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
# Host Color Profiles
# =========================================

set_prompt_palette() {
  if [[ -n $CONTAINER_ID ]]; then

    HEAD_C='#008080'
    BODY_C1='#80ff80'
    BODY_C2='#008000'
    SUCCESS_C='#0000ff'
    FAILED_C='#ff0000'

    MODE_FLG="DistroBox"

  elif ((ZSH_SUBSHELL_LEVEL > 0)); then

    HEAD_C='#000000'
    BODY_C1='#ffffff'
    BODY_C2='#808080'
    SUCCESS_C='#40cc40'
    FAILED_C='#cc4040'

    MODE_FLG="SubShell"

  else
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

      localhost*)
        HEAD_C='#ffffff'
        BODY_C1='#80ff80'
        BODY_C2='#408040'
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

    MODE_FLG="Normal"

  fi
}

# =========================================
# Utilities
# =========================================

DISTRO_NAME="$($HOME/Dotfiles/scripts/bin/distro-name)"

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
  local sym="${PROMPT_SYMS[RANDOM % $#PROMPT_SYMS + 1]}"

  PROMPT+="%F{${BODY_C1}}" 
  PROMPT+=" ${CURVE_BOTTOM}${CENTER_LINE}" 
  PROMPT+=" %(?.%F{${SUCCESS_C}}.%F{${FAILED_C}}) "
  PROMPT+="%F{${BODY_C1}}" 
  PROMPT+=" ${CENTER_LINE}"
  PROMPT+=" ${sym}"
  PROMPT+=" ${CENTER_LINE}${ARROW_RIGHT_THIN} "
  PROMPT+="%f" 
}

# =========================================
# Header Line
# =========================================

print_header() {

  case "$MODE_FLG" in
  
    DistroBox*)
      PLACE="$DISTRO_NAME on DistroBox Lv.$ZSH_SUBSHELL_LEVEL"
	;;

    SubShell*)
      if [[ -n "$NVIM" ]]; then
        PLACE="NVIM"
      elif [[ -n "$IN_NIX_SHELL" ]]; then
          PLACE="NIX"
      elif [[ -n "$TMUX" ]]; then
        PLACE="TMUX"
      else
        PLACE="SUB"
      fi

      PLACE+=" Lv.$ZSH_SUBSHELL_LEVEL"
        ;;

    Normal*)
      PLACE="${DISTRO_NAME}"
        ;;
  esac

  print -P ""

  print -P \
"%K{${HEAD_C}} \
%K{${BODY_C1}}%F{${BODY_C2}} %n@%m [${PLACE}] \
%K{${BODY_C2}}%F{${BODY_C1}}${ARROW_RIGHT}\
%K{${BODY_C2}}%F{${BODY_C1}} zsh ${ZSH_VERSION} \
%k%F{${BODY_C2}}${ARROW_RIGHT}%f"
}

# =========================================
# Mid Line
# =========================================

print_middle() {

  if [[ -n "${vcs_info_msg_0_}" ]]; then
    GIT="${CENTER_LINE} ${vcs_info_msg_0_}"
  else
    GIT=""
  fi

  print -P \
"%F{${BODY_C1}}\
 ${CURVE_TOP}${CENTER_LINE}\
 %~\
 ${GIT}\
%f"
}

# =========================================
# precmd
# =========================================

precmd() {
  set_prompt_palette

  vcs_info

  PROMPT=""

  print_header
  print_middle
  build_left_prompt
}
