" Vars
"
let s:is_win      = has('win32') || has('win64')
let $MY_VIMRUNTIME = expand(s:is_win ? '~/vimfiles' : '~/.vim')
"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (noexpandtab:展開しない)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" タブをスペースで入力
set expandtab
" 自動生成されるインデントの文字数
set shiftwidth=4
" タブを押したときの幅
set softtabstop=4
" クリップボードを利用する
set clipboard=unnamed

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:


" カラースキーマ
colorscheme elflord
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:▸\ ,eol:¬
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile

"---------------------------------------------------------------------------
" エンコードに関する設定
"
" vimの文字コード設定
set encoding=utf-8
" ファイルを開く文字コード
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

"---------------------------------------------------------------------------
" その他
"
" deleteキーを使えるようにする
set t_kD=^?
" 改行コードをunix(LF)とする
set fileformat=unix 
" phpで文法チェック
set makeprg=php\ -l\
"helpを日本語優先に
set helplang=ja

"
"全角スペースを表示させる
"
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
 
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" 挿入モード時の色指定
" https://github.com/fuenor/vim-statusline/blob/master/insert-statusline.vim
if !exists('g:hi_insert')
  let g:hi_insert = 'highlight StatusLine guifg=White guibg=DarkCyan gui=none ctermfg=White ctermbg=DarkCyan cterm=none'
endif
 
if has('unix') && !has('gui_running')
  inoremap <silent> <ESC> <ESC>
  inoremap <silent> <C-[> <ESC>
endif
 
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
 
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
 
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"
"quick Escaping
"
inoremap jj <Esc>

" Neobundle
" @see http://qiita.com/Kuchitama/items/68b6b5d5ed40f6f96310
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

NeoBundle 'https://github.com/Shougo/neobundle.vim'
NeoBundle 'https://github.com/Shougo/vimproc.vim'
NeoBundle 'https://github.com/kana/vim-fakeclip'
NeoBundle 'https://github.com/scrooloose/syntastic'
NeoBundle 'https://github.com/Shougo/neocomplcache.vim'
NeoBundle 'https://github.com/tell-k/vim-browsereload-mac'
NeoBundle 'https://github.com/oppara/taglist.vim'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'
NeoBundle 'git://github.com/miripiruni/csscomb-for-vim.git'
NeoBundle 'https://github.com/mhinz/vim-startify'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'https://github.com/yegappan/mru'

"
"分割ウィンドウ時に移動を行う設定
"
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l


"---------------------------------------------------------------------------
"
" プラグイン固有の設定
"
"---------------------------------------------------------------------------
"syntastic
"https://github.com/scrooloose/syntastic
"
let $JS_CMD='node'
"ファイルを開いたときにチェックするか 1:true
let g:syntastic_check_on_open = 0
"セーブ時にチェックするか 1:true
let g:syntastic_check_on_save = 1
"自動で:Errorsを実行するか 1:true
let g:syntastic_auto_loc_list = 1
"Errorsを表示する高さ
let g:syntastic_loc_list_height = 5
"シンタックスエラーの箇所に自動的にジャンプするか否か
let g:syntastic_auto_jump = 0
"左側にサインを出すか
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }

" let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
" let g:syntastic_php_checkers = ['php', 'phpmd']
let g:syntastic_php_checkers = ['php']

" let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_javascript_checkers = ['jsl', 'gjslint']
if (has('mac'))
  let g:syntastic_javascript_jsl_conf = $MY_VIMRUNTIME . '/tools/jsl.osx.conf'
else
  let g:syntastic_javascript_jsl_conf = $MY_VIMRUNTIME . '/tools/jsl.conf'
endif
let g:syntastic_json_checkers = ['jsonlint']


"---------------------------------------------------------------------------
"neocomplcache (ネオコン)
"https://github.com/Shougo/neocomplcache.vim

" 補完ウィンドウの設定
set completeopt=menuone
 
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
 
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion  =  1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 2

" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"

" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()

" 補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()

" 改行で補完ウィンドウを閉じる
" inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
 
" <C-h>や<BS>を押したときに確実にポップアップを削除します
inoremap <expr><C-h> neocomplcache#smart_close_popup().”\<C-h>”

" 現在選択している候補を確定します
inoremap <expr><C-y> neocomplcache#close_popup()

" 現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()

"---------------------------------------------------------------------------
" vim-browserload-mac
" https://github.com/tell-k/vim-browsereload-mac
" リロード後MacVimにフォーカスを当てる
let g:returnApp = "MacVim"

"---------------------------------------------------------------------------
" vim-startify
let g:startify_bookmarks = ['~/.vimrc']

" --------------------------------------------------------------------------
" vim-indent-guides
" https://github.com/nathanaelkane/vim-indent-guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" --------------------------------------------------------------------------
" vim-taglist
let Tlist_Show_One_File = 1 "現在編集中のソースのタグしか表示しない
let Tlist_Exit_OnlyWiindow = 1 "taglist が最後のウインドウなら vim を閉じる
let g:tlist_php_settings = 'php;c:class;d:constant;f:function'

" --------------------------------------------------------------------------
" mru.vim
" 保存するファイル履歴の数
let MRU_Max_Entries = 20
" ファイルリストウィンドウの高さ
let MRU_Window_Height = 8
" カレントのウィンドウに表示するか
let MRU_Use_Current_Windo = 1
" ファイル選択時、ファイルリストのウィンドウを閉じるか
let MRU_Auto_Close = 1
