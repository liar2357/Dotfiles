export ARROW_RIGHT=$'\ue0b0'
export ARROW_LEFT=$'\ue0b2'

export HEAD_C='#80ff80'
export BODY_C1='#8080ff'
export BODY_C2='#80ffff'

export SUCCESS_C='#40cc40'
export FAILED_C='#cc4040'

PROMPT_SYMS=('( - ω -)つ' '(_ ˙꒳˙)_' '(∩ ˇ ω ˇ ∩)' '(^o^)' '(ﾉ･ω ･)ﾉ' '(ง˘ω ˘)ว' '(；´Д｀)' '(=^･ω･^=)' '(▼･ω･▼)' 'c(U*･× ･)U' '(♡ > ω < ♡)' '(*ˊᗜ ˋ)ﾉﾞ')

function random_prompt {
  local sym=${PROMPT_SYMS[RANDOM % $#PROMPT_SYMS + 1]}
 
  PROMPT="%K{${HEAD_C}} %K{${BODY_C1}}%F{${BODY_C2}} ${sym} %k%F{${BODY_C1}}%k${ARROW_RIGHT}%f "
  RPROMPT="%F{${BODY_C1}}${ARROW_LEFT}%K{${BODY_C1}} %B%(?.%F{${SUCCESS_C}}○ SUCCESS.%F{${FAILED_C}}✘ FAILED%f)%b %K{${HEAD_C}} %f%k"
}

precmd() {
  print -P ""
  print -P "%K{${HEAD_C}} %K{${BODY_C1}}%F{${BODY_C2}} %n@%m %K{${BODY_C2}}%F{${BODY_C1}}${ARROW_RIGHT}%F{${BODY_C1}} %D %* %K{${BODY_C1}}%F{${BODY_C2}}${ARROW_RIGHT}%F{${HEAD_C}} %~  %K{black}%F{${BODY_C1}}%k${ARROW_RIGHT}%f"
  random_prompt
}
