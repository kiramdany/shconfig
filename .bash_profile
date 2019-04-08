# select correct node version by running nvm use if applicable
updateNodeVersion() {
  if [ "$PWD" == "$MYOLDPWD" ]; then
    return
  fi
  MYOLDPWD="$PWD"
  local nvmrcFile="$(nvm_find_nvmrc)"
  # Declare nvmrc before so that the [-z] (string test) works as expected
  nvmrc=''
	[ -z "$nvmrcFile" ] ||  nvmrc="$(cat $nvmrcFile)"
  if [ -z "$nvmrc" ]; then
    return
  fi
  # This always starts with a v and has the complete version
  local nodeVersion="$(node -v)"
  # nvmrc can be written in any level of detail starting from Major.Minor.Patch
  # So want to test if nodeVersion contains nvmrc
  # TODO: Handle the case where nvmrc also starts with a 'v'
  local diff="${nodeVersion#v$nvmrc}"
  # If they are the same then nvmrc wasn't contained in nodeVersion so need to change node version
  if [ "$diff" == "${nodeVersion}" ]; then
    nvm use
  fi
}

# This is run before every prompt
# Add updateNodeVersion to existing prompt command
export PROMPT_COMMAND="updateNodeVersion${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# shortcut to get ip address
ip() {
  ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | tee /dev/tty | pbcopy
}
# static file server
serve() {
    #TODO: check for python version
    python -m SimpleHTTPServer
}
# set title of iTerm2 tabs
title () {
    echo -ne "\033]0;"$*"\007"
}


export PATH=/Users/k.ramdany/scala/bin:$PATH
#export PS1='\w$\$(parse_git_branch)\[\033[00m\] $ '
export PS1="\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
source ~/.bash_apparix
source ~/.git-completion.bash

# Turn off escape character for ctrl+s so as to enable forward search
stty -ixon

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(pyenv init -)" # init pyenv to choose python version similiar to rvm and nvm


# shortcut to opening files with google chrome
alias chrome='open -a "Google Chrome"'
# shortcut to opening projects with Android Studio
alias studio='open -a "Android Studio"'
# displays folders with trailing slash
alias ls='ls -pG'

# git aliases
alias gc='git commit'
alias gco='git checkout'
alias ga='git a'
alias gl='git log'
alias gd='git diff --color-words'

#git scripts
sync() {
  git checkout master
  git pull
  git checkout -
  git rebase master
}

export PATH="$HOME/.cargo/bin:$PATH"
