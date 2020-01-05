
"                                 CHEN                                     "
"                              VIM-PYTHON                                  "
"                                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"								插件管理
set nocompatible              " be iMproved, required
set hidden
filetype off                  " required


"if filereadable(expand("~/.vim/.vimrc.bundle"))
"  	source ~/.vim/.vimrc.bundle
"endif

if filereadable(expand("~/.vim/.vimrc.plug"))
  	source ~/.vim/.vimrc.plug
endif

"filetype plugin indent on
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
"Fast edit vimrc
""""""""""""""""""""""""""""""
function! MySys()
 if has("win32")
   return "windows"
 else
   return "linux"
 endif
endfunction


function! SwitchToBuf(filename)
  "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
  " find in current tab
 let bufwinnr = bufwinnr(a:filename)
 if bufwinnr != -1
	 exec bufwinnr . "wincmd w"
	return
 else
	" find in each tab
	tabfirst
	let tab = 1
	while tab <= tabpagenr("$")
		let bufwinnr = bufwinnr(a:filename)
		if bufwinnr != -1
		exec "normal " . tab . "gt"
		exec bufwinnr . "wincmd w"
		return
		endif
		tabnext
		let tab = tab + 1
	endwhile
	 " not exist, new tab
	 exec "tabnew " . a:filename
 endif
endfunction


let mapleader = ","
if MySys() == 'linux'
  "Fast reloading of the .vimrc
  map <silent> <leader>ss :source ~/.vimrc<cr>
  "Fast editing of .vimrc
  map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
  "When .vimrc is edited, reload it
  autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
  " Set helplang
  set helplang=cn
  "Fast reloading of the _vimrc
  map <silent> <leader>ss :source ~/_vimrc<cr>
  "Fast editing of _vimrc
  map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
  "When _vimrc is edited, reload it
  autocmd! bufwritepost _vimrc source ~/_vimrc
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               基本配置
"
"开启语法高亮
 syntax on
"syntax enable
"
"自动、智能缩进
 autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
 autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab
 autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
 autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
 autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
 autocmd BufRead *.css setlocal ts=2 sts=2 sw=2 expandtab
 autocmd BufRead *.json setlocal ts=2 sts=2 sw=2 expandtab
 autocmd BufRead *.vue setlocal ts=2 sts=2 sw=2 expandtab
 autocmd BufRead *.wxml setlocal ts=2 sts=2 sw=2 expandtab
 autocmd BufRead *.wxss setlocal ts=2 sts=2 sw=2 expandtab
 set autoindent
 set cindent
 set smartindent
 set fileformat=unix
 filetype indent on

"paste toggle
"" set pastetoggle=<C>t
"中文乱码"
 set fileencodings=utf-8,chinese
"默认展开所有代码
" tips : 用za 来 fold/unfold
 set foldmethod=indent
 nnoremap <space><space> za
 set foldlevel=99
"显示当前的行号列号：
 set ruler
"显示行号：
 set number
"行宽
set textwidth=9999
"自动折行
"set nowrap
 set wrap
"在html标签之间跳转(%)
 runtime macros/matchit.vim
" 搜索
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present
"在当前目录及子目录下用find打开指定文件
 set path=./**
"恢复上次光标位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"启动界面
 set shortmess=atI
"Alt 组合键不映射到菜单上
 set winaltkeys=no

imap jj <Esc>
imap <C-h> <left>
imap <C-l> <right>
cmap q<CR> qa<CR>

"MacOS
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   mac os map
if has('mac') && ($TERM == 'xterm-256color' || $TERM == 'screen-256color')
map <Esc>OP <F1>
map <Esc>OQ <F2>
map <Esc>OR <F3>
map <Esc>OS <F4>
map <Esc>[16~ <F5>
map <Esc>[17~ <F6>
map <Esc>[18~ <F7>
map <Esc>[19~ <F8>
map <Esc>[20~ <F9>
map <Esc>[21~ <F10>
map <Esc>[23~ <F11>
map <Esc>[24~ <F12>
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"							nerdtree
"
"不显示帮助信息
 let NERDTreeMinimalUI=1
"鼠标点击
 let NERDTreeMouseMode = 2
"宽度
 let g:NERDTreeWinSize = 30
"忽略文件、隐藏文件
 let NERDTreeIgnore = ['\.pyc$']
 let NERDTreeSortOrder=['\/$', 'Makefile', 'makefile', '*', '\~$']
 nmap wm :NERDTreeToggle<cr>
 autocmd StdinReadPre * let s:std_in=1
 autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"		window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"关闭当前窗口
 nmap wc      <C-w>c
"分割窗口
 nmap wv      <C-w>v
 nmap ws      <C-w>s

"打开quickfix
nnoremap co :copen<cr><<Esc>
nnoremap cc :cclose<cr><Esc>
nnoremap cb :cbottom<cr><Esc>
nnoremap cn :cnext<cr><Esc>
nnoremap cp :cprev<cr><Esc>

"" nmap w<c-n>  <C-w>n
"" nmap w:      <C-w>:
"分割窗口移动快捷键
nnoremap wh  <c-w>h
nnoremap wj  <c-w>j
nnoremap wk  <c-w>k
nnoremap wl  <c-w>l
nnoremap wp  <c-w>p

" resize the windows
nnoremap w<up>   <c-w>+
nnoremap w<down>   <c-w>-
nnoremap w<left>   <c-w><
nnoremap w<right>   <c-w>>

"""""""""""""""""""""""""""""
" terminal
" """"""""""""""""""""""""""
tnoremap <Esc> <C-W>N
au BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif

"autocmd BufRead *.py :NERDTreeToggle
"关闭窗口
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             ctags
"
"let Tlist_Ctags_Cmd='/usr/bin/ctags'
"let Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8/bin/ctags'
"用法：$ ctags –R 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"							 tagbar
autocmd BufRead *.* nmap tb :Tagbar<cr>
"let tagbar_ctags_bin='/usr/bin/ctags'
let tagbar_width=35
"let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_previewwin_pos = "aboveleft"
autocmd BufWinEnter * if &previewwindow | setlocal nonumber | endif
"let g:tagbar_autopreview = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           YouCompleteMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'

set completeopt=longest,menu 					" 让Vim的补全菜单行为与一般IDE一致
let g:ycm_confirm_extra_conf = 0 				" 不用每次提示加载.ycm_extra_conf.py文件
let g:ycm_show_diagnostics_ui = 0 				" 关闭ycm的syntastic

let g:ycm_complete_in_comments = 1 				" 评论中也应用补全
let g:ycm_min_num_of_chars_for_completion = 2			" 两个字开始补全
let g:ycm_collect_identifiers_from_tags_files=1 		" 开启 YCM 基于标签引擎
let g:ycm_cache_omnifunc=0 					" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax = 1 			" 关键字补全
""上下左右键的行为 会显示其他信息
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-k>\<C-j>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-k>\<C-j>" : "\<PageUp>"

"set YouCompleteMe trigger key
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
"let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"let g:ycm_key_list_previous_completion = ['<Up>']

"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

let g:ycm_key_invoke_completion = '<Enter>'
let g:ycm_semantic_triggers =  {'c' : ['->', '.'], 'objc' : ['->', '.'], 'ocaml' : ['.', '#'], 'cpp,objcpp' : ['->', '.', '::'], 'php' : ['->', '::'], 'cs,java,javascript,vim,coffee,python,scala,go' : ['.'], 'ruby' : ['.', '::']}

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>j :YcmCompleter GoTo<CR>

"autocmd BufRead *.py nnoremap <C-]> :YcmCompleter GoTo<CR>
autocmd BufRead *.js nnoremap <C-]> :TernDef<CR>


nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                jedi-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"

"let g:jedi#popup_on_dot = 0    " 用.触发
"let g:jedi#popup_select_first = 0   " 自动选择菜单第一项

let g:jedi#goto_command = "d"
let g:jedi#goto_assignments_command = "<C-]>"
let g:jedi#goto_definitions_command = ""
let g:jedi#usages_command = "<C-u>"
let g:jedi#documentation_command = "<C-g>"
let g:jedi#completions_command = "<C-m>"

"let g:jedi#completions_enabled = 0     "disable jedi


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 错误检查
"
"let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1

"安装flake8: easy_install flake8
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_jshint_exec = '/usr/local/bin/eslint'
'
"Default: 0
"If enabled, syntastic will do syntax checks when buffers are first loaded as
"well as on saving >
 "let g:syntastic_check_on_open=1

"Default: 0
"Enable this option to tell syntastic to always stick any detected errors into
"the loclist: >
 let g:syntastic_always_populate_loc_list=1

"Default: 2
"When set to 1 the error window will be automatically opened when errors are
"detected, and closed when none are detected. >
"" let g:syntastic_auto_loc_list=1

"When set to 2 the error window will be automatically closed when no errors are
"detected, but not opened automatically. >
let g:syntastic_auto_loc_list=2

"only errors no warnings
 let g:syntastic_quiet_messages={'level': 'warnings'}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               pydiction
 let g:pydiction_location = '/work/home/.vim/bundle/pydiction/complete-dict'
" let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
 let g:pydiction_menu_height = 20
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"										ultisnips
" Track the engine.
"Bundle 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
"Bundle 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Emmet
"
let g:user_emmet_expandabbr_key = '<C-e>'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 SimpylFold
" 代码折叠
let g:SimpylFold_docstring_preview=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 FastFold
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Cuda *.cu as cpp filetype
au BufNewFile,BufRead *.cu
    \ set filetype=cpp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  py文件头
"autocmd bufnewfile *.py call HeaderPython()
"function HeaderPython()
"    call setline(1, "#!/usr/bin/env python")
"    call append(1, "# -*- coding: utf-8 -*-")
"    normal G
"    normal o
"    normal o
"endf
function! ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    call append(1, "# -*- coding: utf-8 -*-")
    if &filetype == 'python'
        call append(2, cfg)
    endif
    normal ''
    set tags+=$HOME/.vim/tags/python.ctags
endfunction

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

au BufNewFile,BufRead *.py  set tags+=$HOME/.vim/tags/python.ctags

au BufNewFile,BufRead *.py
    \ set tabstop=4      |
    \ set softtabstop=4  |
    \ set shiftwidth=4   |
    \ set fileformat=unix |
let python_highlight_all=1
    "\ set textwidth=79   |
    "\ set expandtab      |
    "\ set autoindent     |
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 docstring
nmap <silent> <C-a> <Plug>(pydocstring)
"template
""""
":param {{_args_}}:
"{{_indent_}}:return:
""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ctrlP
" 当前目录查找
let g:ctrlp_working_path_mode = 'ra'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               power-line
"set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                markdown
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_toc_autofit = 1
autocmd BufRead *.md nmap tb :Toc<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""
" Copy & Pase
"set clipboard=unnamed
" """""""""""""""""""""""

"""""""""""""""""""""""""
" Quickly run
" """"""""""""""""""""""
map <F4> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		"exec "!go build %<"
		exec "!time go run %"
	elseif &filetype == 'mkd'
		exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
	endif
endfunc


""""""""""""""""""""""""""""""
" mark setting
""""""""""""""""""""""""""""""
"nmap <silent> <leader>hl <Plug>MarkSet
"vmap <silent> <leader>hl <Plug>MarkSet
"nmap <silent> <leader>hh <Plug>MarkClear
"vmap <silent> <leader>hh <Plug>MarkClear
"nmap <silent> <leader>hr <Plug>MarkRegex
"vmap <silent> <leader>hr <Plug>MarkRegex
" For mark plugin
"hi MarkWord1 ctermbg=Cyan ctermfg=Black guibg=#8CCBEA guifg=Black
"hi MarkWord2 ctermbg=Green ctermfg=Black guibg=#A4E57E guifg=Black
"hi MarkWord3 ctermbg=Yellow ctermfg=Black guibg=#FFDB72 guifg=Black
"hi MarkWord4 ctermbg=Red ctermfg=Black guibg=#FF7272 guifg=Black
"hi MarkWord5 ctermbg=Magenta ctermfg=Black guibg=#FFB3FF guifg=Black
"hi MarkWord6 ctermbg=Blue ctermfg=Black guibg=#9999FF guifg=Black

let g:mwDefaultHighlightingPalette = 'extended'
let g:mwDefaultHighlightingNum = 9
let g:mwAutoLoadMarks = 1


""""""""""""""""""""""""""""""
" vim-cellmode
" """"""""""""""""""""""""""""
" C-c send current selected lines to tmux
" C-g sends the current cell to tmux
" C-b d

"noremap <silent> <C-a> :call RunTmuxPythonAllCellsAbove()<CR>
"let g:cellmode_use_tmux=1
"let g:cellmode_use_tmux=1
"let g:cellmode_use_tmux=1

""""""""""""""""""""""""""""""
" indentLine
" """"""""""""""""""""""""""""
let g:indentLine_concealcursor="nc"
let g:indentLine_fileTypeExclude=['tex', 'json']
let g:indentLine_setColors=1

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
nmap <silent> <Leader>be   :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0 " Do not how default help.
let g:bufExplorerShowRelativePath=1 " Show relative paths.
let g:bufExplorerSortBy='mru' " Sort by most recently used.
let g:bufExplorerSplitRight=0 " Split left.
let g:bufExplorerSplitVertical=1 " Split vertically.
let g:bufExplorerSplitVertSize = 30 " Split width
let g:bufExplorerUseCurrentWindow=1 " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber


""""""""""""""""""""""""""""""
" vim-cpp-enhanced-highlight.vim
""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

""""""""""""""""""""""""""""""
" gtags.vim
" To go to the referenced point of 'func', add -r option.
"       :Gtags -r func
"
" To go to any symbols which are not defined in GTAGS, try this.
"       :Gtags -s func
"
" To go to any string other than symbol, try this.
"       :Gtags -g ^[sg]et_
"
" To get list of objects in a file 'main.c', use -f command.
"       :Gtags -f main.c
"

"let g:Gtags_Auto_Map=1
let g:Gtags_Auto_Update=1
noremap <C-\><C-f> :Gtags -P <C-R>=expand("<cfile>")<CR><CR>
noremap <C-\><C-g> :Gtags <C-R>=expand("<cword>")<CR><CR>
noremap <C-\><C-s> :Gtags -s <C-R>=expand("<cword>")<CR><CR>
noremap <C-\><C-r> :Gtags -r <C-R>=expand("<cword>")<CR><CR>
noremap <C-\><C-e> :Gtags -g <C-R>=expand("<cword>")<CR>
noremap <C-\><C-]> :GtagsCursor<CR>
""""""""""""""""""""""""""""""
" gtags-cscope.vim
"	explanation		command
"	----------------------------------------------------------
"	Find symbol		:cs find 0 or s
"	Find definition		:cs find 1 or g
"	Find functions called by this function	(not implemented)
"	Find reference		:cs find 3 or c
"	Find text string	:cs find 4 or t
"	Find egrep pattern	:cs find 6 or e
"	Find path		:cs find 7 or f
"	Find include file	:cs find 8 or i
let g:GtagsCscope_Auto_Load=1
let g:GtagsCscope_Auto_Map=0
"set csprg='/work/bin/gtags-cscope'
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
set cst
"set csto=1
set csprg='gtags-cscope'
set tagstack
set cscopetag
" normal command
:nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>r :cs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
":nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" Using 'CTRL-spacebar', the result is displayed in new horizontal window.
:nmap <C-\><C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\><C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\><C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\><C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\><C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
:nmap <C-\><C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
:nmap <C-\><C-\>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
":nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
" Hitting CTRL-space *twice*, the result is displayed in new vertical window.
"":nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
"":nmap <C-@><C-@>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
":nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
"":nmap <C-[> :ta<CR>
"":nmap <C-t> :pop<CR>
"":nmap <C-[> :tag<CR>
"CTRL-T			Jump to [count] older entry in the tag stack
" Context search. See the --from-here option of global(1).
:nmap <C-\>] :cs find d        <C-R>=expand("<cword>")<CR>:<C-R>=line('.')<CR>:%<CR>
:nmap <C-\>n :tn<CR>
:nmap <C-\>p :tp<CR>
:nmap <C-\>[ :top<CR>

":nmap <C-\>a :Ack       <C-R>=expand("<cword>")<CR>:<C-R>=line('.')<CR>:%<CR>
:nmap <C-\>a :Ack       <C-R>=expand("<cword>")<CR><CR>
"let g:GtagsCscope_Auto_Load=1
"let g:GtagsCscope_Quiet=1
"let g:loaded_gentags#gtags=0
"let g:loaded_gentags#ctags=1
"nnoremap <C-\><C-]> :GtagsCursor<CR>
"
"

"""""""""""""""""""""""""""""
" pyclewn
"let g:pyclewn_terminal="xterm,-e"

" ConqueGdb
let g:ConqueGdb_SrcSplit='above'
"let g:ConqueGdb_SaveHistory=1
let g:ConqueGdb_Continue='<F5>'
let g:ConqueGdb_Next='<F10>'
let g:ConqueGdb_Step='<F9>'
let g:ConqueGdb_Finish = '<F8>'
let g:ConqueGdb_Print = '<F12>'
":noremap <F12> :ConqueGdbCommand
" command! -nargs=+ ConqueGdbCommand call conque_gdb#command(<q-args>)
"    let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r'
"    let g:ConqueGdb_Print = g:ConqueGdb_Leader . 'p'
"    let g:ConqueGdb_Finish = g:ConqueGdb_Leader . 'f'
"    let g:ConqueGdb_Backtrace = g:ConqueGdb_Leader . 't'
:noremap <F12> ":\<C-u>ConqueTermVSplit sh\n\<C-o>:call feedkeys('python '.shellescape(bufname(".bufnr("%").")).\"\\n\")\n"

"""""""""""""""""""""""""""""
" bufExplorer
"let g:bufExplorerShowTabBuffer=1        " Yes.
" f/F open buffer under current window
" v/V open buffer on right of current window
" o open buffer is under cursor into current window
" s cycle through buffers are listed
" leader,bt,bs,bv

"""""""""""""""""""""""""""""
" ctrlspace
"
  let g:CtrlSpaceDefaultMappingKey = "<C-l>"
  let g:airline#extensions#ctrlspace#enabled = 1
  let g:CtrlSpaceUseTabline = 1
  let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
  if executable("ag")
      let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif

"""""""""""""""""""""""""""""
" ycm
  let g:airline#extensions#ycm#enabled = 1

"""""""""""""""""""""""""""""
" bufferline
"
"let g:bufferline_show_bufnr = 5
"let g:bufferline_rotate = 1


" integrated with airline
""* enable/disable bufferline integration >
  let g:airline#extensions#bufferline#enabled = 0

""* determine whether bufferline will overwrite customization variables >
  let g:airline#extensions#bufferline#overwrite_variables = 0

"""""""""""""""""""""""""""""
" airline
""

let g:airline_powerline_fonts = 1

  let g:airline_left_sep='>'
  let g:airline_right_sep='<'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  "let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  "let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  "let g:airline_symbols.linenr = '☰'
  "let g:airline_symbols.linenr = '␊'
  "let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  "let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  "let g:airline_symbols.paste = 'Þ'
  "let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  "let g:airline_left_sep = ''
  "let g:airline_left_alt_sep = ''
  "let g:airline_right_sep = ''
  "let g:airline_right_alt_sep = ''
  "let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  "let g:airline_symbols.linenr = '☰'
  "let g:airline_symbols.maxlinenr = ''

"let g:airline_extensions = ['branch', 'tabline', 'bufferline']
let g:airline_extensions = ['branch', 'tabline']

" airline tabline

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers = 1
""* enable/disable displaying tabs, regardless of number. (c) >
let g:airline#extensions#tabline#show_tabs = 1

"let g:airline#extensions#tabline#left_sep=' '
"let g:airline#extensions#tabline#left_alt_sep='|'
"let g:airline#extensions#tabline#right_sep = ''
"let g:airline#extensions#tabline#right_alt_sep = ''

"let g:airline#extensions#tabline#buffer_idx_mode=1


"enable/disable displaying open splits per tab (only when tabs are opened). >
"let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tab_nr=1

""* enable/disable displaying tab type (far right) >
  let g:airline#extensions#tabline#show_tab_type = 1


""* define the set of filetypes which are ignored selectTab keymappings
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree', 'tagbar']


nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
""* change the display format of the buffer index >
"let g:airline#extensions#tabline#buffer_idx_format = {
"        \ '0': '0 ',
"        \ '1': '1 ',
"        \ '2': '2 ',
"        \ '3': '3 ',
"        \ '4': '4 ',
"        \ '5': '5 ',
"        \ '6': '6 ',
"        \ '7': '7 ',
"        \ '8': '8 ',
"        \ '9': '9 '
"        \}

" "* configure whether buffer numbers should be shown. >
"      let g:airline#extensions#tabline#buffer_nr_show = 1

" tab
noremap <C-k>o :tabnew<CR>
noremap <C-k>c :tabclose<CR>
noremap <C-k>p :tabnext<CR>
noremap <C-k>n :tabprev<CR>
"noremap <C-k>h <Plug>AirlineSelectPrevTab
"noremap <C-k>l <Plug>AirlineSelectNextTab


"let g:airline_theme='molokai'
"let g:airline_theme='zenburn'
let g:airline_theme='powerlineish'

"""""""""""""""""""""""""""""""""""""""""
" asyncrun
" ex
"":AsyncRun git push origin master
"":AsyncRun gcc % -o %<
"":AsyncRun ctags -R --fields=+S .
"":AsyncRun grep -R <cword> .


"""""""""""""""""""""""""""""""""""""""""
" ShowTrailingWhitespace
"一键清楚行尾空白符
nnoremap <leader>w  :%s/\s\+$//<cr>:let @/=''<CR>

"""""""""""""""""""""""""""""
"      	                          主题
"set termguicolors
set t_Co=256
"let g:monokai_term_italic = 1
"let g:monokai_gui_italic = 1
colorscheme monokai


"if !exists("g:vimrc_loaded")
    "colorscheme molokai
    "let g:molokai_original = 1
    "let g:rehash256 = 1
    if has("gui_running")
        set guioptions-=T "隐藏工具栏
        set guioptions-=L
        set guioptions-=r
        set guioptions-=m
        set gfn=Source\ Code\ Pro\ for\ Powerline\ Semi-Bold\ 10
        set gfw=STHeiti\ 9
        set langmenu=en_US
        set linespace=0
    endif " has
"endif " exists(...)

"colorscheme editplus
"colorscheme zenburn

"set background=dark
"colorscheme solarized
"call togglebg#map("<F8>")
"

python << EOF
import os
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" usage: gf enter import file,  ctrl+^ back to old file
" python tips:
" ctrl + > or < 左右缩进
" ctrl + > or < 左右缩进

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  clang format
"
"clang-format for formating cpp code

let g:clang_format#code_style = "webkit"
let g:clang_format#style_options = {
        \ "AccessModifierOffset" : -4,
        \ "AllowShortIfStatementsOnASingleLine" : "true",
        \ "AlwaysBreakTemplateDeclarations" : "true",
        \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
"nnoremap <leader>cf :call FormatCode("webkit")<cr>
"nnoremap <leader>lf :call FormatCode("LLVM")<cr>
"vnoremap <leader>cf :call FormatCode("webkit")<CR>
"vnoremap <leader>lf :call FormatCode("LLVM")<cr>
"let g:autoformat_verbosemode = 1
"func FormatCode(style)
"  let firstline=line(".")
"  let lastline=line(".")
"  " Visual mode
"  if exists(a:firstline)
"    firstline = a:firstline
"    lastline = a:lastline
"  endif
"  let g:formatdef_clangformat = "'clang-format --lines='.a:firstline.':'.a:lastline.' --assume-filename='.bufname('%').' -style=" . a:style . "'"
"  let formatcommand = ":" . firstline . "," . lastline . "Autoformat"
"  exec formatcommand
"endfunc
