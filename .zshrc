# �䴰��ǽON
autoload -U compinit
compinit

setopt auto_pushd
setopt auto_cd
setopt correct
setopt cdable_vars

#cd 
cdpath=(..~~/src )

#default permission
#new 644
#new dir 755
umask 022

#ailas define
#alias mv ='nocorrect mv'
#alias cp ='nocorrect cp'
#alias mkdir ='nocorrect mkdir'
alias ls="ls -GF"
alias grep=egrep
#alias ll ="ls -l"
alias la="ls -lhAF --color=auto"
alias emacs="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
#search .file
alias pdf="/Applications/Preview.app/Contents/MacOS/Preview"
alias lsa="ls -ld .*"

#PROMPT
PROMPT="%m%# "
RPROMPT=" %~"

#man directory path
#manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man)
manpath=($X11HOME/man /usr/share/man/ /usr/local/share/man/) 
export MANPATH

HISTSIZE=2000
SAVEHIST=10000
HISTFILE=~/.zhistory
DIRSTACKSIZE=20


## Default shell configuration
#
# set prompt
#
autoload colors
colors
#case ${UID} in
#0)
#    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
#    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    ;;
#*)
#    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
#    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
#    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#    ;;
#esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=fxgxcxdxbxegedabagacad
#    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=01;35:ln=36:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=35' 'ln=36' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac
