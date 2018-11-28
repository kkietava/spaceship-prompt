#
# Virtualenv
#
# virtualenv is a tool to create isolated Python environments.
# Link: https://virtualenv.pypa.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_VENV_SHOW="${SPACESHIP_VENV_SHOW=true}"
SPACESHIP_VENV_PREFIX="${SPACESHIP_VENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_VENV_SUFFIX="${SPACESHIP_VENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_VENV_SYMBOL="${SPACESHIP_VENV_SYMBOL=""}"
# The (A) expansion flag creates an array, the '=' activates word splitting
SPACESHIP_VENV_GENERIC_NAMES="${(A)=SPACESHIP_VENV_GENERIC_NAMES=virtualenv venv .venv}"
SPACESHIP_VENV_COLOR="${SPACESHIP_VENV_COLOR="blue"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current virtual environment (Python).
spaceship_pipenv() {
  [[ $SPACESHIP_VENV_SHOW == false ]] && return

  # Check if the current directory running via Virtualenv
  [ -n "$VIRTUAL_ENV" ] || return

  local 'venv'

  local XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  local WORKON_HOME="${WORKON_HOME:-$XDG_DATA_HOME/virtualenvs}"

  if [[ "$PIPENV_ACTIVE" && "$VIRTUAL_ENV" == "$WORKON_HOME"* ]]; then
      venv=${(j:-:)${${(@s|-|)VIRTUAL_ENV:t}[1,-2]}}
  else
      if [[ "${SPACESHIP_VENV_GENERIC_NAMES[(i)$VIRTUAL_ENV:t]}" -le \
            "${#SPACESHIP_VENV_GENERIC_NAMES}" ]]
      then
        venv="$VIRTUAL_ENV:h:t"
      else
        venv="$VIRTUAL_ENV:t"
      fi
  fi

spaceship::section \
    "$SPACESHIP_VENV_COLOR" \
    "$SPACESHIP_VENV_PREFIX" \
    "${SPACESHIP_VENV_SYMBOL}${venv}" \
    "$SPACESHIP_VENV_SUFFIX"
}
