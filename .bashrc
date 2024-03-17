#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -z $TMUX ]] && tmux

export VISUAL=vim
export WINEDEBUG=-all
export WINEARCH=win64

# GPG agent setup
if [[ -S "/run/user/${UID}/gnupg/S.gpg-agent.ssh" ]]; then
	if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
		gpg-connect-agent /bye >/dev/null 2>&1
	fi
	unset SSH_AGENT_PID
	if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
		export SSH_AUTH_SOCK="/run/user/${UID}/gnupg/S.gpg-agent.ssh"
	fi
fi

numcpu=`lscpu|grep '^CPU(s): *'|awk '{print $2}'`
if [[ ! -z "${numcpu}" ]]; then
	alias make="make -j${numcpu}"
	export CMAKE_BUILD_PARALLEL_LEVEL="${numcpu}"
fi

alias ls='ls --color=auto'
alias rebar='rebar3'
export PS1='[\u@\h \W]\$ '

# Add local bin to PATH
if [[ -d "${HOME}/bin" ]]; then
	export PATH="${PATH}:${HOME}/bin"
fi

if [[ -d "${HOME}/.local/bin" ]]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi

# Add most-recently installed Stack-managed Haskell to PATH
if [[ -d "${HOME}/.stack/programs/$(uname -m)-$(uname -s|tr 'A-Z' 'a-z')/" ]]; then
	stacklocation=$(find "${HOME}/.stack/programs/$(uname -m)-$(uname -s|tr 'A-Z' 'a-z')/" -maxdepth 2 -mindepth 2 -type d -name 'bin' | tail -1)
	if [[ -d "${stacklocation}" ]]; then
		export PATH="${stacklocation}:${PATH}"
	fi
fi

if [[ -d "${HOME}/.cabal/bin" ]]; then
	export PATH="${HOME}/.cabal/bin:${PATH}"
fi

# Add yarn-managed files to PATH (primarily for elm)
if [[ -d "${HOME}/.yarn/bin" ]]; then
	export PATH="${HOME}/.yarn/bin:${PATH}"
fi

# Add RVM to PATH
if [[ -d "${HOME}/.rvm/bin" ]]; then
	export PATH="${PATH}:${HOME}/.rvm/bin"
fi

# Pull in host-specific variables if applicable
if [[ -f "${HOME}/.bash_vars" ]]; then
	. "${HOME}/.bash_vars"
fi
