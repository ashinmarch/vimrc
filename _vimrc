set nocompatible
set mouse=a
set guifont=courier_new:h10
set expandtab
set shiftwidth=4
set tabstop=4
set showmatch
set autoindent
set smartindent
set paste
"set nowrap
set number
syntax enable
syntax on
"setlocal spell spelllang=en
colorscheme desert
"set encoding=utf-8
"set fileencodings=utf-8,gb18030,utf-16,big5
"set langmenu=zh_CN.UTF-8
"language message zh_CN.UTF-8
"set fencs=utf-8
"set termencoding=cp936
set tags=$VIMRUNTIME/tags
set autochdir
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

"Personal Highlighting
highlight ErrorMsg ctermbg=red guibg=red ctermfg=yellow guifg=yellow cterm=bold


behave mswin
"map <F11> <Esc>:call libcallnr(�gvimfullscreen.dll? �ToggleFullScreen? 0)<CR>

if exists('+colorcolumn')
  set colorcolumn=81
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"informative status line
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"Ctrl+F2 to toggle or remove menu & toolbar
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>


:amenu <silent> Tabs.&Next :tabnext<cr>
:amenu <silent> Tabs.&Previous :tabprevious<cr>

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" also use <num>gt or gT
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>
nnoremap tf :tabfirst<CR>
nnoremap tl :tablast<CR>
nnoremap tl :tablast<CR>

" abbreviate
:ab #i #include
:ab #d #define
:ab #b /************************************************
:ab #e <Space>**********************************************/
:ab #l /*----------------------------------------------*/
