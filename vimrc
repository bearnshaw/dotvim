" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set backspace=2		" more powerful backspacing

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup


"
" end of system vimrc
"


" pathogen
call pathogen#infect()

" autoreload vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" map leader to ,
let mapleader = ","

" use line numbers
set number

" use wildmenu
set wildmenu

" yank to clipboard
set clipboard=unnamed

" dealing with backups
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,$HOME/Local\ Settings/Temp

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" dealing with whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" trim whitespace
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre *.rb,*.edn,*.clj,*.xml,*.html,*.html.mustache,*.css,*.scss,*.less,*.js,*.coffee,*.sql,*.vim :call TrimWhiteSpace()

" Ruby, edn, sh
autocmd BufNewFile,BufRead *.rb,*.edn setl expandtab sw=2 ts=2 sts=2
autocmd BufNewFile,BufRead * if &ft == 'sh' | setl expandtab ts=2 sw=2 | endif

" web syntax: xml, html, css, scss, less, js, coffee
autocmd BufNewFile,BufRead *.xml,*.html,*.html.mustache,*.css,*.scss,*.less,*.js,*.coffee,*.sql,*.vim set ts=2 sts=2 sw=2 smarttab expandtab
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent " nofoldenable

" markdown
au BufRead,BufNewFile *.md setl textwidth=80

" Powerline
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256
let g:Powerline_symbols = 'fancy'
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" useful key bindings
set timeout timeoutlen=500
imap jj <Esc>
imap JJ <Esc>
nnoremap <BS> :noh<return><BS>
nnoremap <Leader>s :sp<return>
nnoremap <Leader>v :vsp<return>

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
autocmd BufNewFile,BufRead *.tex set ts=2 sts=2 sw=2 tw=80 smarttab expandtab wrap linebreak nolist
autocmd FileType tex imap <Leader>i <Plug>Tex_InsertItemOnThisLine
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
""" trouble with this is that it should only be used in latex mode since
""" statements like else: (in python) get tokenized
"set iskeyword+=:
let g:Tex_ViewRule_pdf = 'open -a Preview.app'
set conceallevel=2
let g:tex_conceal= 'adgms'
hi Conceal ctermbg=Black

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
	runtime! macros/matchit.vim
endif

" open and close quickfix window
nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qc :cclose<CR>

" paredit for edn
au BufNewFile,BufRead *.edn set filetype=clojure
au FileType clojure call PareditInitBuffer()

" rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Shortcut to open git page
nmap <leader>o :OpenGithubFile<CR>
vmap <leader>o :OpenGithubFile<CR>

" Use the same symbols as TextMate for tabstops and EOLs
"set listchars=tab:▸\ ,eol:¬

" vim-markdown
let g:vim_markdown_folding_disabled=1

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" ctrp and extensions
let g:ctrlp_extensions = ['funky', 'yankring', 'cmdline', 'menu']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target'
nnoremap <Leader>m :CtrlPModified<CR>
nnoremap <Leader>M :CtrlPBranch<CR>

" funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<CR>

" Gundo
nnoremap <Leader>u :GundoToggle<CR>

" redl
nnoremap <Leader>rr :Repl<CR>
nnoremap <Leader>rq :Req<CR>

" fugitive helpers
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gg :Ggrep 
nnoremap <Leader>gG :execute 'Ggrep ' . expand('<cword>')<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gL :Glog --<CR>
nnoremap <Leader>gm :Gmove 
nnoremap <Leader>gM :Gmove! 
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gP :Git push -f<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gR :Gremove!<CR>
nnoremap <Leader>gs :Gstatus<CR>

" ag helpers
nnoremap <Leader>a :Ag 
nnoremap <Leader>A :execute 'Ag ' . expand('<cword>')<CR>

" vim calc
nnoremap <Leader>c :Calc<CR>

" bufkill
nnoremap <Leader>bk :BD<CR>

" sudo save from buffer
cmap w!! %!sudo tee > /dev/null %

" vim-python-test-runner
nnoremap<Leader>da :DjangoTestApp<CR>
nnoremap<Leader>df :DjangoTestFile<CR>
nnoremap<Leader>dc :DjangoTestClass<CR>
nnoremap<Leader>dm :DjangoTestMethod<CR>
nnoremap<Leader>nf :NosetestFile<CR>
nnoremap<Leader>nc :NosetestClass<CR>
nnoremap<Leader>nm :NosetestMethod<CR>
nnoremap<Leader>rt :RerunLastTests<CR>

" python mode: disable rope
let g:pymode_doc = 0
let g:pymode_rope = 0
let g:pymode_run = 0
