alias cls='clear'
alias cl='cls;ll -CF'
alias dir='ls --color=auto --format=vertical'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lah'
alias ls='ls --color=auto'
alias pu='pushd'
alias po='popd'
alias man='man -L it'
alias vdir='ls --color=auto --format=long'
alias vime='vim -q /tmp/vimErr.err'
alias se='sensible-editor'
alias p='sensible-pager'
alias h='head'
alias g='grep'
alias x='xargs'
alias x0='xargs -0'
alias xg='xargs grep'
alias xc='xargs cat'
alias xp='xargs pager'
alias xf='xargs file'
alias xwc='xargs wc'
alias xet='xargs emacsclient -t'
alias i='info'
alias j='jobs'
alias psh='ps -H'

alias sudeq='sudo emacs -Q -nw'
alias sshx='ssh -X'

alias l1='ls -1'

alias rt='transmission-remote'

## for storage
alias gmountmini='gvfs-mount ssh://jmini.local/'
alias gumountmini='gvfs-mount -u ssh://jmini.local/'

#### fetchmail
alias getmail="fetchmail -U"

####for Emacs
alias e='emacsclient -t -a "emacs -Q -nw"'
alias eq='emacs -Q -nw'
alias vi='emacs -Q -nw'
alias eQ='emacs -Q'
alias ec='emacsclient'
alias et='emacsclient -t'
alias RMAIL='emacs -Q -f rmail'
#alias GNUS='EDITOR= emacsclient -s GNUS -e "(gnus)"'
#alias AGENDA='emacsclient -e "(org-agenda)" -a "emacs -f org-agenda"'
alias emacs-kill='emacsclient --eval "(kill-emacs 1)" -a /bin/false'

#### for Django
alias djval='django-admin.py validate --pythonpath=`pwd` --settings=settings'
alias djrun8800='django-admin.py runserver 0.0.0.0:8800 --pythonpath=`pwd` --settings=settings'
alias djsh='django-admin.py shell --pythonpath=`pwd` --settings=settings'
alias djdbsh='django-admin.py dbshell --pythonpath=`pwd` --settings=settings'

#### LDAP
alias ldaps="ldapsearch -Y EXTERNAL -H ldapi:///"
alias ldapm="ldapmodify -Y EXTERNAL -H ldapi:///"
alias ldapmrdn="ldapmodrdn -Y EXTERNAL -H ldapi:///"
alias ldapa="ldapadd -Y EXTERNAL -H ldapi:///"
alias ldappwd="ldappasswd -Y EXTERNAL -H ldapi:///"
