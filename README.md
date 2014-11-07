dotvim
=======

My .vim directory.  Lots of plugins for developing in python and clojure, and
writing in latex.  Use it at your own risk.

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
