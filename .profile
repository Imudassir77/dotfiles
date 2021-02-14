#!/bin/sh
# shellcheck disable=SC1090,SC2155

#
# ~/.profile
#

# Helper to safely include external scripts
include() {
	if [ -f "$1" ]
	then
		. "$1"
	fi
}

# Helper to calculate PS1
_PS1_DIR() {
	case "$PWD" in
		"$HOME") echo "~"          ;;
		"/")     echo "/"          ;;
		*)       echo "${PWD##*/}" ;;
	esac
}

# Helper to add executables to $PATH
path_add() {
	# If the directory exists, add it to PATH
	if [ -d "$1" ]
	then
		export PATH="$1:${PATH}"

	# Otherwise try as a subdir of XDG_BIN_HOME
	elif [ -d "${XDG_BIN_HOME:-.local/bin}/$1" ]
	then
		export PATH="${XDG_BIN_HOME:-.local/bin}/$1:${PATH}"
	fi
}

# Set standard XDG directories
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# Set nonstandard and pseudo XDG directories
export XDG_BIN_HOME="${HOME}/.local/bin"

# Include alias definitions
include "${XDG_CONFIG_HOME}/aliases/main"

# Add scripts to PATH, its tools may be accessed after this
path_add "scripts"

# Add pfetch to PATH
path_add "pfetch"

# Set the prompt to the current directory and a dollar sign
export PS1='$(_PS1_DIR) $ '

# Set editor commands.
export VISUAL="$(command -v vim 2>/dev/null)"
export EDITOR="$(command -v vi  2>/dev/null)"

# Set PAGER to prevent use of more(1)
export PAGER=less

# Set ENV to provide shell specific settings
export ENV="${XDG_CONFIG_HOME}/ksh/kshrc"

# Fixing misbehaving Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# Set dotnet directories and privacy settings
export DOTNET_ROOT="${XDG_DATA_HOME}/dotnet"
export DOTNET_TOOLS="${DOTNET_ROOT}/tools"
export NUGET_PACKAGES="${DOTNET_ROOT}/nuget/packages"
export DOTNET_NOLOGO="true"
export DOTNET_CLI_TELEMETRY_OPTOUT="true"

# Add dotnet tools to PATH
path_add "${DOTNET_TOOLS}"

# Set pfetch startup script
export PF_SOURCE="${XDG_CONFIG_HOME}/pfetch/config"

# Add pfetch to PATH
path_add "pfetch"

# Set Golang environment
export GOROOT="/usr/local/go"
export GOBIN="${XDG_BIN_HOME}/go/bin"
export GOPATH="${HOME}/go:${XDG_BIN_HOME}/go"

# Add go lang tools to PATH
path_add "${GOROOT}/bin"
path_add "${GOBIN}"

# Add OS specific scripts to PATH
path_add "$(uname | tr '[:upper:]' '[:lower:]')"

# Set X11 init script
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# Make vim respect XDG_CONFIG_DIR
export VIMINIT="set nocp | source ${XDG_CONFIG_HOME}/vim/vimrc"

