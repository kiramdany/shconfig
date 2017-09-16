# select correct node version by running nvm use if applicable
updateNodeVersion() {
  nvmrcFile="$(nvm_find_nvmrc)"
	[ -z "$nvmrcFile" ] ||  nvmrc="$(cat $nvmrcFile)"
  if [ -z "$nvmrc" ]; then
    return
  elif [ "$PWD" != "$MYOLDPWD" ]; then
    MYOLDPWD="$PWD";
    nodeVersion="$(node -v | sed s/v//)"
    if [ "$nvmrc" != "$nodeVersion" ]; then
      nvm use
    fi
  fi
}

# This is run before every prompt
# Add updateNodeVersion to existing prompt command
export PROMPT_COMMAND="updateNodeVersion${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
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


# shortcut to opening files with google chrome
alias chrome='open -a "Google Chrome"'
# displays folders with trailing slash
alias ls='ls -p'
# safety net for rm
alias rm='trash'