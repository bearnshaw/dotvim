dotvim
=======

My .vim directory.  Lots of plugins for developing in python and clojure, and
writing in latex.  Use it at your own risk.

You'll either want to clone this directly into your home directory, symlink from
this directory to `~/.vim`:
```
ln -s /path-to-dotvim ~/.vim
```

I've put my rc files directly into this directory, so you'll want to create
symlinks from these to your home directory.  For example,
```
ln -s /path-to-dotvim/vimrc ~/.vimrc
ln -s /path-to-dotvim/gvimrc ~/.gvimrc
```

I use Tim Pope's [pathogen](https://github.com/tpope/vim-pathogen) to manage my
plugins.  The directory `bundle` contains git submodules for the
pathogen-managed plugins.  Once you clone, please run
```
git submodule update --init --recursive
```
to get all the plugins (and the submodules those plugins depend on).  The only
plugin that will give you grief is
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe).  Believe me, you
want this, but you'll need to visit the link to see how to install it after
cloning.
