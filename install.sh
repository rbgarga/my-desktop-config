#!/bin/sh

if [ -z "$HOME" ]; then
	echo "\$HOME is not set"
	exit 1
fi

if [ ! -d "$HOME" ]; then
	echo "\$HOME directory doesn't exist"
	exit 1
fi

required_binaries="git vim cmake"

for binary in $required_binaries; do
	if ! which $binary >/dev/null 2>&1; then
		echo "${binary} not found"
		exit 1
	fi
done

mydir=$(realpath $(dirname $0 ))
os=$(uname -s)

conf_files="gitconfig git_template synergy.conf vimrc ondirrc"

if [ -d "${HOME}/bin" ]; then
	echo "${HOME}/bin is a directory, skipping... "
else
	ln -sf $mydir/bin $HOME/
fi

if [ "$os" = "FreeBSD" ]; then
	mkdir -p $HOME/.config/awesome $HOME/.config/i3 $HOME/.config/i3status \
	    $HOME/.config/clipit
	ln -sf $mydir/wallpaper.jpg $HOME/.wallpaper.jpg
	ln -sf $mydir/awesome-rc.lua $HOME/.config/awesome/rc.lua
	ln -sf $mydir/i3-config $HOME/.config/i3/config
	ln -sf $mydir/i3status-config $HOME/.config/i3status/config
	ln -sf $mydir/clipitrc $HOME/.config/clipit/clipitrc

	# .login_conf is better being a hardlink
	ln -f $mydir/login_conf $HOME/.login_conf

	conf_files="${conf_files} XCompose Xmodmap Xresources xinitrc xscreensaver"
fi

for conf_file in $conf_files; do
	ln -sf $mydir/$conf_file $HOME/.$conf_file
done

if [ -d "${HOME}/.zprezto" ]; then
	echo "${HOME}/.zprezto is a directory, skipping... "
else
	if ! git clone --recursive git@github.com:rbgarga/prezto.git \
	    ${HOME}/.zprezto; then
		echo "Error cloning prezto"
		exit 1
	fi

	git -C $HOME/.zprezto remote add upstream \
	    git@github.com:sorin-ionescu/prezto.git

	for f in zlogin zlogout zpreztorc zprofile zshenv zshrc; do
		ln -sf $HOME/.zprezto/runcoms/$f $HOME/.$f
	done
fi

${mydir}/vim-install.sh
