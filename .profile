#!/bin/sh
# shellcheck disable=SC1090,SC2155

#
# ~/.profile
#

# Helper functions {{{

# Import common functions
. ~/.local/lib/sh/common

# Helper functions }}}

# XDG Directories {{{

# Set standard XDG directories
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# Set nonstandard and pseudo XDG directories
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"

# Set user-dirs XDG directories
export XDG_DESKTOP_DIR="${HOME}"
export XDG_DOCUMENTS_DIR="${XDG_DESKTOP_DIR}/documents"
export XDG_DOWNLOAD_DIR="${XDG_DESKTOP_DIR}/downloads"
export XDG_MUSIC_DIR="${XDG_DESKTOP_DIR}/media"
export XDG_PICTURES_DIR="${XDG_DESKTOP_DIR}/media"
export XDG_PUBLICSHARE_DIR="${HOME}/public"
export XDG_TEMPLATES_DIR="${XDG_CONFIG_HOME}/templates"
export XDG_VIDEOS_DIR="${XDG_DESKTOP_DIR}/media"

# XDG Directories }}}

# Import external scripts {{{

# Include alias definitions
import "aliases/ls"
import "aliases/mkdir"
import "aliases/cd"
import "aliases/ufetch"
import "aliases/pfetch"
import "aliases/neofetch"

# Import external scripts }}}

# Export external variables {{{

# Set editor commands.
export VISUAL="$(command -v vim 2>/dev/null)"
export EDITOR="$(command -v vi  2>/dev/null)"

# Set PAGER to prevent use of more(1)
export PAGER=less

# Set KSHRC to provide ksh/mksh specific settings
export KSHRC="${XDG_CONFIG_HOME}/ksh/kshrc"

# Set SHRC to provide POSIX generic shell settings
export SHRC="${XDG_CONFIG_HOME}/sh/shrc"

# Set ENV to provide session specific settings
export ENV="${SHRC}"

# Fixing misbehaving Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# Set dotnet directories and privacy settings
export DOTNET_ROOT="${XDG_DATA_HOME}/dotnet"
export DOTNET_TOOLS="${DOTNET_ROOT}/tools"
export NUGET_PACKAGES="${DOTNET_ROOT}/nuget/packages"
export DOTNET_NOLOGO="true"
export DOTNET_CLI_TELEMETRY_OPTOUT="true"

# Set pfetch startup script
export PF_SOURCE="${XDG_CONFIG_HOME}/pfetch/config"

# Set Golang environment
export GOROOT="/usr/local/go"
export GOBIN="${XDG_BIN_HOME}/go/bin"
export GOPATH="${XDG_BIN_HOME}/go"

# Set X11 init script
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

# Make vim respect XDG_CONFIG_DIR
export VIMINIT="set nocp | source ${XDG_CONFIG_HOME}/vim/vimrc"

# Hide .lesshist in XDG_CACHE_HOME
export LESSKEY="${XDG_CONFIG_HOME}/less.key"
export LESSHISTFILE="${XDG_CACHE_HOME}/less.history"

# Move wgetrc to XDG_CONFIG
export WGETRC="$XDG_CONFIG_HOME/wget/config"

# Set git(1) environment variables
export GIT_EDITOR="${VISUAL:-$EDITOR}"
export GIT_PAGER="$PAGER"

# Export external variables }}}

# Update PATH {{{

# Add scripts to PATH, its tools may be accessed after this
using "scripts"

# Add pfetch to PATH
using "pfetch"

# Add dotnet tools to PATH
using "${DOTNET_TOOLS}"

# Add go lang tools to PATH
using "${GOROOT}/bin"
using "${GOBIN}"

# Add OS specific scripts to PATH
using "$(uname | tr '[:upper:]' '[:lower:]')"

# Update PATH }}}

# Run startup scripts {{{

# Startup ssh-agent(1)
if [ -z "$SSH_AUTH_SOCK" ]
then
	eval "$(ssh-agent -s)" >/dev/null 2>&1
fi

# Make sure all XDG directories exist
xdg --mkdir DESKTOP
xdg --mkdir DOCUMENTS
xdg --mkdir DOWNLOAD
xdg --mkdir MUSIC
xdg --mkdir PICTURES
xdg --mkdir PUBLICSHARE
xdg --mkdir TEMPLATES
xdg --mkdir VIDEOS
xdg --mkdir DATA
xdg --mkdir CONFIG
xdg --mkdir CACHE
xdg --mkdir BIN
xdg --mkdir LIB

# Run startup scripts }}}

