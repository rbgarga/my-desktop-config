#!/bin/sh

if ! which node 2>/dev/null; then
	echo "ERROR: node binary not found" >&2
	exit 1
fi

mydir=$(realpath $(dirname $0 ))
vim_dir=${HOME}/.vim
plug_vim=${vim_dir}/autoload/plug.vim
plug_dir=${vim_dir}/vim-plug

if [ -e $plug_vim ]; then
	echo "${plug_vim} is present, skipping... "
else
	ln -sf ${mydir}/vimrc ${HOME}/.vimrc
	mkdir -p $(dirname $plug_vim)
	rm -rf $plug_dir
	if ! git clone https://github.com/junegunn/vim-plug.git $plug_dir; then
		echo "Error clonning plug vim"
		exit 1
	fi
	ln -sf ${plug_dir}/plug.vim $plug_vim
	ln -sf ${mydir}/coc.vimrc ${vim_dir}/coc.vimrc

	vim '+PlugInstall' '+qall'
fi

ln -sf $mydir/freebsd.vim $HOME/.vim/freebsd.vim
