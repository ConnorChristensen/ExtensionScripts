# There are install instructions for some utilities that do not come default
# with MacOS. This assumes that you have already installed homebrew and npm.

# Changes the default terminal prompt
export PS1="\W > "

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
# Install: brew install ncdu
alias scan="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
# Install: npm install -g tldr
alias help="tldr"
# Install: brew install youtube-dl
alias youtubemp3="youtube-dl -x --audio-format mp3"
alias cz="npm run commit"

# Note: pass a --dry-run to test
alias sync="rsync --verbose --update --human-readable --progress --itemize-changes"
alias minify="perl -pi -e 's/\s+//g'"
# short for perl-in-line
alias pil="perl -pi -e"

# link to the sbin path for some possible homebrew files
export PATH="/usr/local/sbin:$PATH"

# Add local pip to path
export PATH="${PATH}:${HOME}/.local/bin/"
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences | tr -d "\n" &)


# Note on better command line utilities to use
# bat is better than cat
# fd is better than find
# both can be installed with homebrew

# get pyenv set up
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
