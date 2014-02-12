# utf-8
alias biggest='du -sm *|sort -rn|head'
alias space='df -PHT hfs'
alias ls='ls -F'
alias routes='netstat -f inet -rn'

# https://github.com/christianbundy/whereami
whereami() {
	echo "$(whoami)@$(hostname):$(pwd)" | (pbcopy)
	echo "$(tput setaf 2)$(whoami)$(tput setaf 0)@$(tput setaf 3)$(hostname)$(tput setaf 0):$(tput setaf 6)$(pwd)$(tput sgr0)"
}
# https://github.com/christianbundy/sshcd
sshcd() {
	t="${!#}"
	c=("ssh" "-t" "${@:1:$(($#-1))}" "${t%:*}" "cd ${t##*:}; \$SHELL -l")
	"${c[@]}"
}
sshlra() {
	port="$1"
	sshcd -p $port dlmaint@lra.tun:/var/www/lightrules
}

export EDITOR=subl

# put anything in here that should not be distributed (machine-specific or security related)
if [ -f ".bash_profile.local" ]; then
	source ".bash_profile.local"
fi

LESS="-R"

alias speak="say -v zarvox -r 150"

alias githead='HASH=`git rev-parse --short HEAD` && echo $HASH && printf "%s " $HASH | pbcopy'

binstall() { bundle install --path $HOME/dl/vendor/$1/bundle --binstubs $HOME/dl/vendor/$1/bin ; }

binstallm() { bundle install --trust-policy MediumSecurity --path $HOME/dl/vendor/$1/bundle --binstubs $HOME/dl/vendor/$1/bin ; }

binstallh() { bundle install --trust-policy HighSecurity --path $HOME/dl/vendor/$1/bundle --binstubs $HOME/dl/vendor/$1/bin ; }

# username for [tarball style] code push
LRUSER=dlmaint
# hostname for [tarball style] code push
LRHOST=lrlurv

# shortcut for tarball copy
lrup() { 
	if [ -z "$HASH" ]; then
		HASH=$(git rev-parse --short HEAD)
	fi
	if [ -z "$LRHOST" ]; then
		echo "please set LRHOST in your environment"
		return
	fi
	file="LRWeb-${HASH}.tar.gz"
	if [[ -f $file ]]; then
		echo copying $file to $LRHOST:
		scp $file ${LRUSER}@${LRHOST}:/tmp
	else
		echo "file $file hasn't been created yet."
	fi
}

crules() {
	app=$1
	shift
	echo "heroku $* --app crules-$app"
	heroku $* --app crules-$app
}
alias millard="crules millard"
alias lineage="crules lineage"
alias staging="crules staging"

export PIDFILE_DIR=/tmp

if [ -f "git-completion.sh" ]; then

  source git-completion.sh

fi

if [ -f "git-prompt.sh" ]; then

  source git-prompt.sh

	BLACK="\[\033[0;30m\]"
	RED="\[\033[0;31m\]"
	YELLOW="\[\033[0;33m\]"
	GREEN="\[\033[0;32m\]"
	BLUE="\[\033[0;34m\]"
	VIOLET="\[\033[0;35m\]"

	GIT_PS1_SHOWDIRTYSTATE=y

	PS1="\h:\W$BLUE\$(__git_ps1)$BLACK 🍺 ∵ "
fi

if [ -d "/Applications/Postgres93.app/Contents/MacOS/bin" ]; then
  PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
fi

# node via brew

if [ -d "/usr/local/share/npm/bin" ]; then
  PATH="$PATH:/usr/local/share/npm/bin"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
