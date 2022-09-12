## Provider-specific env

export PROVIDER_HOME_DIRECTORY=/Users/ethan.stark/workspace/provider
export GOPATH=$PROVIDER_HOME_DIRECTORY/go 

export CURRENT_DB=captain401-provider-2022-06-30
export DATABASE_URL=postgres://localhost/$CURRENT_DB?sslmode=disable
export TZ=UTC

## Source GO in $PATH
## export PATH=$PATH:/usr/local/opt/go


## WF-specific env

export ENCRYPTION_KEY=R79nKLagPtIJH81lS+JcrKW25OUnr8DycqxpEBbBcGU=

## VS Code

## Shell integration

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

## Plugins

source ~/.zsh/spaceship-prompt/spaceship.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fpath=(~/.zsh/zsh-completions/ $fpath)

## Spaceship settings


SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
# Simplify prompt if we're using Hyper
if [[ "$TERM_PROGRAM" == "Hyper" ]]; then
  SPACESHIP_PROMPT_SEPARATE_LINE=false
  SPACESHIP_DIR_SHOW=false
  SPACESHIP_GIT_BRANCH_SHOW=false
fi

## Auto-complete


autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


### Ethan's custom aliases

function current_branch() {
  git rev-parse --abbrev-ref HEAD
}

alias ca="code ."
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dc="docker-compose"
alias d="docker"
alias yyd="yarn && yarn dev"
alias yd="yarn dev"
alias gs='git status'
alias yt='yarn test'
alias grh='git reset --hard origin/$(current_branch)'
alias ydi='yarn dev:include_tests'
alias y='yarn'
# conflicts with oh-my-zsh default aliases

alias gcm='git commit -m'
alias gpu='git push -u origin HEAD'
alias gma='git checkout master'

# oh-my-zsh aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gco='git checkout'
alias gf='git fetch'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gp='git push'
