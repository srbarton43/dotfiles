########## Aliases #############
alias ls="ls -G"
alias ll="ls -alh"
alias l="ls -lh"
alias py="python3"
alias pip="pip3"
alias cdp="cd .."
alias gittree="tree -a --gitignore -I .git"
# pipe tree cmd into less with colors
treeless(){ tree -C $1 | less -r; }
# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

###### GIT Aliases ############
alias gg="git status"
alias gcm="git commit -v"
alias ga="git add"
alias gap="git add -p"
alias gall="git add ."
alias gl="git log --graph --one-line"
alias gd="git diff"
alias gp="git push"

######### PATH ##############
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/Users/sbarton/Library/Python/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH=$PATH:'/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home/bin'
export PATH=/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/homebrew/bin:$PATH

######### Other #############
export EDITOR="nvim"
