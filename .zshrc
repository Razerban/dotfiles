###########################
# iTerm2 shell integration
###########################
if [[ "$OSTYPE" == *darwin* ]]; then
	if [[ ! -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
		curl -L https://iterm2.com/shell_integration/zsh -o "${HOME}/.iterm2_shell_integration.zsh"
	fi
	source "${HOME}/.iterm2_shell_integration.zsh"
fi

###########################
# Zplug init
###########################
if [[ ! -e "${HOME}/.zplug" ]]; then
	git clone https://github.com/zplug/zplug "${HOME}/.zplug"
	source "${HOME}/.zplug/init.zsh" && zplug update
fi
source "${HOME}/.zplug/init.zsh"

###########################
# PATHS
###########################
# HOMEBREW
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_AUTO_UPDATE_SECS=604800# PostgreSQL
# JAVA
JAVA_HOME="$(/usr/libexec/java_home)"
export JAVA_HOME

###########################
# ENVIRONMENT VARIABLES
###########################
# System:
if [[ -n "${SSH_CONNECTION}" ]]; then
	export EDITOR='vi'
else
	export EDITOR='vi'
fi
export LANG=en_US.UTF-8

###########################
# ALIASES
###########################
# User specific
alias update='brew update; brew upgrade; brew cask upgrade'
alias clean='brew cleanup'
alias ping='ping -c 5'
alias clear='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'
alias path='echo -e ${PATH//:/\\n}'
alias mkdir='mkdir -pv'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias gs='git status'
alias gc='git commit'
alias gp='git pull --rebase'
alias gcam='git commit -am'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

###########################
# FUNCTIONS
###########################
function enable_install_from_anywhere() {
	sudo spctl --master-disable
}
function install_xcode_cli_tools() {
  xcode-select --install
}

###########################
# Zplug plugins
###########################
autoload colors && colors
setopt prompt_subst

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh, if:"[[ ${OSTYPE} == *darwin* ]]"
zplug "plugins/colorize", from:oh-my-zsh

zplug "plugins/docker", from:oh-my-zsh
zplug "sroze/docker-compose-zsh-plugin"
zplug "Cloudstek/zsh-plugin-appup"
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/ansible", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zuxfoucault/colored-man-pages_mod"
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/screen", from:oh-my-zsh
zplug "plugins/gnu-utils", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/zsh_reaload", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/zsh-navigation-tools", from:oh-my-zsh
zplug "plugins/compleat", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "caarlos0-graveyard/zsh-pg"
zplug "peterhurford/git-aliases.zsh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "cristiancavalli/ys-zsh-custom-theme", as:theme
zplug "b4b4r07/httpstat", \
	as:command, \
	use:'(*).sh', \
	rename-to:'$1'
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug check || zplug install
# Then, source packages and add commands to $PATH
zplug load
clear

