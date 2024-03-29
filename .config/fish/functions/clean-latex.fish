function clean-latex
  find -E . -maxdepth 2 -type f -regex '.*\.(log|aux|synctex\.gz|fdb_latexmk|fls)$' -delete
end
