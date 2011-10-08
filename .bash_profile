# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
umask 022
unset LC_ALL LANG LANGUAGE
[ -z "$DISPLAY" ] && LC_ALL="C" || LC_ALL=it_IT.utf8
LANG=it_IT.utf8
LANGUAGE=it_IT.utf8

# GPG Agent
if test -f $HOME/.gpg-agent-info && \
    kill -0 `cut -s -d: -f2 $HOME/.gpg-agent-info` 2>/dev/null; then
    . "$HOME"/.gpg-agent-info
else
    eval `gpg-agent --enable-ssh-support --write-env-file --daemon`
    # eval `gpg-agent --write-env-file --daemon`
    # eval `ssh-agent`
fi
export GPG_AGENT_INFO SSH_AGENT_PID SSH_AUTH_SOCK


PATH=/sbin:/usr/sbin:"${PATH}"
MANPATH=/usr/share/man:/usr/local/share/man:/gnu/share/man
INFOPATH=/gnu/share/info:/usr/share/info:/usr/local/share/info

### D-Bus Session
sys_pid=$(cat /var/run/dbus/pid)
pids=$(pidof -o $sys_pid dbus-daemon)
echo sys: $sys_pid ... and $pids
if test -z "$pids" ; then
    if test -z $DBUS_SESSION_ADDRESS ; then
	echo Launch D-Bus ... NO!
#	eval `dbus-launch --exit-with-session`
    fi
fi


### GNUstep Settings Up ...
GNUSTEP_SH=`gnustep-config --variable=GNUSTEP_MAKEFILES`/GNUstep.sh
[ -f ${GNUSTEP_SH} ] && source ${GNUSTEP_SH}
GS_SETUP=~/GNUstep/.gs-setup
[ -f ${GS_SETUP} ] && . ${GS_SETUP}
# echo 'sourced .gs-setup '
## Not in .GNUstep.conf because is not a standard variable. (gnustep-config ugly it)
GNUSTEP_USER_MAKEFILES=`gnustep-config --variable=GNUSTEP_USER_LIBRARY`/Makefiles
export GNUSTEP_USER_MAKEFILES

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi


EMAIL=bardelli.marco@gmail.com
# For packaging in a debian way
DEBEMAIL=${EMAIL}
DEBFULLNAME="Marco Bardelli"

# For editing
EDITOR="emacsclient"
ALTERNATE_EDITOR="emacs"

export PATH LANG MANPATH INFOPATH EDITOR ALTERNATE_EDITOR
export DEBEMAIL DEBFULLNAME


# emacs always lives
run_emacs &

export LC_ALL LANG LANGUAGE
export ___BASH_PROFILE_IS_EXPORTED=yes
# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
# echo 'sourced .bashrc '

#[ `tty` = "/dev/tty2" ] && ( festival --tts /home/fanaj/nuova_suoneria.txt & )
