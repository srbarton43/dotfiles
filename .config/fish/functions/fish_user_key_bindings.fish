function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind \cl true
        
        bind \ce 'fzf_cd_widget'
        bind \cw 'fzf_cd_cwd_widget'
        bind \cv 'fzf_paste_widget'
        #bind \co 'fzf_paste_cwd_widget'

    end
end
