load_file() {
  if [ -f $(echo "$1") ]; then
    source $1
  else
    print "404: $1 not found."
  fi
}

load_file ~/.zsh/default
load_file ~/.zsh/user
