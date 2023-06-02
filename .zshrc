# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

############ Theme ##################
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

########### Plugins ##############
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vscode)
source $ZSH/oh-my-zsh.sh

########## Aliases #############
alias ll="ls -alH"
alias l="ls -lh"
alias py="python3"
alias pip="pip3"
# pipe tree cmd into less with colors
treeless(){ tree -C $1 | less -r; }
# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

######### PATH ##############
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/Users/sbarton/Library/Python/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH=$PATH:'/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home/bin'
export PATH=/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/homebrew/bin:$PATH

######### Other #############
export EDITOR="nvim"
