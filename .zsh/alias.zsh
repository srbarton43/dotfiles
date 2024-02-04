########## Aliases #############
alias cl=clear
alias '...'='cd ../../'
alias -- -='cd -'
alias ls="ls -G"
alias lsa="ls -a"
alias ll="ls -alh"
alias la="ls -Alh"
alias l="ls -lh"
alias py="python3"
alias pip="pip3"
alias gittree="tree -a --gitignore -I .git"
alias grep="grep --color"
alias file="color_file"
alias skim='/Applications/Skim.app/Contents/MacOS/Skim' # for neovim latex only
alias matlab='/Applications/MATLAB_R2023a.app/bin/matlab -nodesktop'
alias oskim='open -a Skim'


###### GIT Aliases ############
alias gg="git status"
alias gcm="git commit -v"
alias ga="git add"
alias gap="git add -p"
alias gall="git add ."
alias gl="git log --graph --one-line"
alias gd="git diff"
alias gp="git push"
alias gmt="git mergetool"
alias glog="git log; clear"

#TEST#
alias ez="exec zsh"

###### LATEX #######
# Cleans latex directory
# keeps only pdf and .tex files
alias clean-latex="find -E . -maxdepth 2 -type f -regex '.*\.(log|aux|synctex\.gz|fdb_latexmk|fls)$' -delete"
