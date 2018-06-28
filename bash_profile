#Changes the default terminal prompt
export PS1="\W > "

# Some aliases for easier command line usage
alias ll="ls -FGlAhp"
alias mkdir="mkdir -pv"
alias c="clear"
alias f="open -a Finder ./"
alias ..="cd ../"
alias .2="cd ../.."
alias .3="cd ../../../"
alias gs="git status"
alias graph="git log --graph --decorate --oneline"

# Pywal - Import colorscheme from 'wal' asynchronously
# &          # Run the process in the background.
# ( )        # Hide shell job control messages.
# tr -d "\n" # Remove any new line characters
(cat ~/.cache/wal/sequences | tr -d "\n" &)
