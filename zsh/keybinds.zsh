zle -N fzf-cd-widget
bindkey -M emacs '\C-e' fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget

zle -N fzf-paste-widget
bindkey -M emacs '\C-p' fzf-paste-widget
bindkey -M vicmd '\C-p' fzf-paste-widget
bindkey -M viins '\C-p' fzf-paste-widget

zle -N fzf-paste-widget-cwd
bindkey -M emacs '\C-o' fzf-paste-widget-cwd
bindkey -M vicmd '\C-o' fzf-paste-widget-cwd
bindkey -M viins '\C-o' fzf-paste-widget-cwd

zle     -N            fzf-history-widget
bindkey -M emacs '\C-r' fzf-history-widget
bindkey -M vicmd '\C-r' fzf-history-widget
bindkey -M viins '\C-r' fzf-history-widget
