### FUNCTIONS #####

# pipe tree cmd into less with colors
treel(){ tree -C $1 | less -r; }

# mkdir and cd into it
cdm() { mkdir "$1"; cd "$1"; }

# find file with matching substring
substr_find() {
  find . -name "*$1*" -maxdepth 3 -exec ls -Gdl {} \;
}

# file cmd with colored seperations
color_file() {
  file "$1" | sed -e 's/^/'"$(printf '\033[0;34m')"'/' -e 's/:/&'"$(printf '\033[0m')"'/'
}
