# OH MY ZSH SETTINGS

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="kali"

# Load plugins
plugins=(
	git
	command-not-found
	zsh-autosuggestions
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# USER SETTINGS

# Set options
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# Color prompt
force_color_prompt=yes

# ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Add shi to path: pipx, snap
export PATH="$PATH:/home/mikey/.local/bin:/snap/bin:/home/mikey/bin:/sbin"
export XDG_DATA_DIRS="/usr/share/:/usr/local/share/:/var/lib/snapd/desktop"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
