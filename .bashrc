# Bashrc dotfile
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Shell options
export CLICOLOR=1
export LSCOLORS=ExBxhxDxfxhxhxhxhxcxcx
export GREP_OPTIONS='--color=auto'
export EDITOR=vim
export PAGER=less

# Prompt
PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#-------------------------------------------------------------
# PATH additions
#-------------------------------------------------------------

# GNU coreutils - warning, will overwrite macOS system utils!
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Golang workspace
#export GOPATH=$HOME/Code/devhost
export GOPATH=$HOME/go/
export PATH="/Users/dkolkena/go/bin:$PATH"

#-------------------------------------------------------------
# Color aliases
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

# Normal Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

NC="\033[0m"              # Color Reset
ALERT=${BWhite}${On_Red}  # Bold White on red background


# Import aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# Vagrant alpha env values
export MYROCKBOXNO=rock401
export MYROCKBOXHASH=cf6fc7a6a1156950fc1dd97a7ea1e88da3fb1801f109e74886db4b31ad982907f5e1532b300a46b69883e7ff9a81f1cea0edc42a7c736539ee61b6d8b1cd44d26bb60f08c1e47bff7d066d803656aad797afaf39833e663fdaf39dfee68ff704224f025bdd363bfd15729c8644aa0e1318881a21205b4551337369a8c12ef918ac8ff2a424af9fb011f3d2a2556a561215458e69794783144bae4c0c090ebe5ef428f226794b185e64fbb0502851c7b7442fc2b96da195802e7f192cdb0062c83dd1e348c825c853b314c5d8e0959245d7551a8ac84bf1f91a95a9332e49e1a2f10fbd8b84cc216aaa05256d566b1ba1f77922f934c022169a6b42a8bc0b0fcba087b8f0659324ce30b3570f7fc3ec5cd6d7df3b088d084f912f01411a49a1d4e81472b6b5fe0f1a6363316176e637b84b5a62a51919efe86422048c713705e3aac5122304c58278312d475437dea9753cfb455fe1985493fa374460e009e518108ee357a569be4014b65b0846df0a4c5e47d46ab919121d591a88da612783701f865b5424fc6449e47d89836f28ae1bc5194d4138966cf9cf9c1cdc935ba322d950cff316f2508f66e05bd045184b17a80a67c8b0a9ed5a1c540edb4b7231f14964d2d20cc1e6ba5741408d76f21c0b780903438551eed2a5d09e7f931782a9
