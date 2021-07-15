" -*- coding: utf-8 -*-
set encoding=utf-8 " このvimrcのエンコーディング

" plug#begin から plug#end の間で Plug 'repo/name' で指定したものが
" .vimrcを読み込みなおして :PlugInstall でインストールできる
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'

Plug 'jpalardy/vim-slime'
" 自前でキーマッピングする
let g:slime_no_mappings = 1
" 始点からVで選択モードに入ってjjj…と降りてきて終点に辿り着いた時点で
" 右人差し指はjに置いてあると筈なので<C-j>にマップする
" ノーマルモードで<C-j>を押した場合、現在行前後のパラグラフが送られる
xmap <C-j> <Plug>SlimeRegionSend
nmap <C-j> <Plug>SlimeParagraphSend
let g:slime_target = "tmux"
" 現在は<prefix>+qで表示されるpane番号が2番のpaneにテキストが送られるように設定されているが、
" {right-of}を指定して、現在ペインの右側に送る設定や
" {marked}を指定して<prefix>+mでマークした(枠の色が変わる)ペインに送るように設定を変更できる。
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
let g:slime_python_ipython = 1
let g:slime_dont_ask_default = 1

call plug#end()

" vimrcの最後にすべき設定
filetype plugin indent on
set t_Co=256
syntax on
set termguicolors
silent! colorscheme molokai
