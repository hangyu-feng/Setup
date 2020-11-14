# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git colorize colored-man-pages command-not-found)

source "${ZSH}/oh-my-zsh.sh"

source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

pull() {
  origin=$(git branch --show-current) &&
  stashed=false
  if [[ `git status --porcelain` ]]; then
    git stash &&
    stashed=true
  fi
  if [[ $# -eq 0 ]]; then
    git pull
  else
    for branch in $@; do  # can use { as well
      git checkout $branch && git pull
    done
  fi
  git checkout $origin &&
  if $stashed; then  # -n checks if string is non-empty. opposite: -z
    git stash pop
  fi
}

LS_COLORS='ow=01;36;40' && export LS_COLORS

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
#   prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshrc="vi ~/setup/configs/.zshrc"
alias vimrc="vi ~/setup/configs/.vimrc"
alias reload="source ~/.zshrc"
alias upsetup="cd ~/setup && pull && cd -"
# alias ohmyzsh="mate ~/.oh-my-zsh"
umask 002
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/home/linuxbrew/.linuxbrew/opt/mysql@5.7/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/opt/imagemagick@6/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
