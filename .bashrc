#
# ~/.bashrc - base config; automatically messed with by ghcup, rvm, etc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -z $TMUX ]] && tmux

alias ls='ls --color=auto'
export PS1='[\u@\h \W]\$ '

# Add local bin to PATH
if [[ -d "${HOME}/bin" ]]; then
	export PATH="${PATH}:${HOME}/bin"
fi
if [[ -d "${HOME}/.local/bin" ]]; then
	export PATH="${HOME}/.local/bin:${PATH}"
fi

# Run local configuration
if [[ -f "${HOME}/.bash_local" ]]; then
	. "${HOME}/.bash_local"
fi

# Pull in host-specific variables if applicable
if [[ -f "${HOME}/.bash_vars" ]]; then
	. "${HOME}/.bash_vars"
fi

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

if [[ -d "${HOME}/.yarn/bin" ]]; then
  export PATH="${PATH}:${HOME}/.yarn/bin"
fi

if [[ -d "${HOME}/.cargo/bin" ]]; then
  export PATH="${PATH}:${HOME}/.cargo/bin"
fi

[ -f "/home/wuest/.ghcup/env" ] && . "/home/wuest/.ghcup/env" # ghcup-env
