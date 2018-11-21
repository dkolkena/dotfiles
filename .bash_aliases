# Bash Aliases dotfile
# Many of these are sourced from 
# https://www.tldp.org/LDP/abs/html/sample-bashrc.html

#-------------------
# Personal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i' 
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias ls='ls -GpF'
alias ll='ls -lah'
alias tree='tree -C'

# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# simple ip
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
# more details
alias ip1="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kH'

alias pip='pip3'
alias python='python3'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias loadbash='source ~/.bash_profile ~/.bashrc ~/.bash_aliases'
alias dicker='docker'

alias nao='telnet alt.org' # Nethack Online


#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

export PAGER=less
export LESSCHARSET='latin1'
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# # LESS man page colors (makes Man pages more readable).
# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'


#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig en0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "You are logged on ${BRed}$HOST"
    echo -e "${BRed}Additional information:$NC " ; uname -a
    echo -e "${BRed}Users logged on:$NC " ; w -h |
             cut -d " " -f1 | sort | uniq
    echo -e "${BRed}Current date:$NC " ; date
    echo -e "${BRed}Machine stats:$NC " ; uptime
    echo -e "${BRed}Memory stats:$NC " ; free
    echo -e "${BRed}Diskspace:$NC " ; mydf / $HOME
    echo -e "${BRed}Local IP Address:$NC " ; my_ip
    echo -e "${BRed}Open connections:$NC "; sudo lsof -PiTCP -sTCP:LISTEN;
    echo
}

# #-------------------------------------------------------------
# # A few fun ones
# #-------------------------------------------------------------

# # Adds some text in the terminal frame (if applicable).
# function xtitle()
# {
#     case "$TERM" in
#     *term* | rxvt)
#         echo -en  "\e]0;$*\a" ;;
#     *)  ;;
#     esac
# }


# # Aliases that use xtitle
# alias top='xtitle Processes on $HOST && top'
# alias make='xtitle Making $(basename $PWD) ; make'

# .. and functions
# function man()
# {
#     for i ; do
#         xtitle The $(basename $1|tr -d .[:digit:]) manual
#         command man -a "$i"
#     done
# }


