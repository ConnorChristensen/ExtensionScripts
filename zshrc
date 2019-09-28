#!/bin/bash

# onlt show current working directory
export PS1="%1d > "

# draw lines in front of prompt
setopt promptsubst
export PS1=$'${(r:$COLUMNS::\u2500:)}'$PS1

# personal aliases
alias ll="ls -FGlAhp"
alias mkdir="mkdir -pv"
alias c="clear"
alias f="open -a Finder ./"
alias ..="cd ../"
alias .2="cd ../.."
alias .3="cd ../../../"
alias gs="git status"
alias graph="git log --graph --decorate --oneline"
alias atom="open -a atom"
alias scan="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help="tldr"
alias youtubemp3="youtube-dl -x --audio-format mp3"
alias cz="npm run commit"
# pass a --dry-run to test before doing
alias sync="rsync -t --verbose --update --human-readable --progress --itemize-changes"
alias minify="perl -pi -e 's/\s+//g'"
# short for perl-in-line
alias pil="perl -pi -e"
alias history="git-file-history"
alias git-linechange="git log --stat --decorate --graph --oneline"
alias grs="git rebase -i --autosquash"
alias gr="git rebase -i"
alias gf="git commit --fixup"
alias seed="rails --rakefile Rakefile development:seed"
# the ncu package is "npm-check-updates"

# docker
alias portainer="docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer"
alias swagger-editor="docker run -d -p 8081:8080 swaggerapi/swagger-editor && echo 'swagger editor running at localhost:8081'"

# link to /usr/local/bin
export PATH="/usr/local/bin:$PATH"

# link to the sbin path for some possible homebrew files
export PATH="/usr/local/sbin:$PATH"

# Add local 'pip' to PATH:
export PATH="${PATH}:${HOME}/.local/bin/"

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences | tr -d "\n" &)


# better utilities
# bat > cat
# fd > find
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

