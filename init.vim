" Vim with all enhancements
"          _____             _____   ____   _____  
"         |  __ \     /\    / ____| / __ \ |  __ \ 
"         | |__) |   /  \  | |  __ | |  | || |__) |
"         |  _  /   / /\ \ | | |_ || |  | ||  _  / 
"         | | \ \  / ____ \| |__| || |__| || | \ \ 
"         |_|  \_\/_/    \_\\_____| \____/ |_|  \_\
"                                                                      
" STARTUP & Pre-CONFIG {{{
"
"{{{
"" ==================== Auto load for first time uses ====================
if empty(glob('~/AppData/Local/nvim/plugged'))
	silent !curl -fLo ~/AppData/Local/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"
"}}}
set mouse=a
" Mouse behavior (the Windows way)
behave mswin
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
"let $LANG = 'zh_CN.UTF-8'
let $LANG = 'en_US.UTF-8'
language messages en_US.UTF-8
filetype plugin indent on    " required
" 自定义命令用   ,
let mapleader=" "
" vim自带命令用空格来替代:
noremap ; :
" }}}


" ------------------------------------------------------------------------
" PLUG -LIST{{{
" ------------------------------------------------------------------------
call plug#begin('~/AppData/Local/nvim/plugged')
" Theme
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'

" Python
Plug 'jiangmiao/auto-pairs'
" File navigation
Plug 'preservim/nerdtree'
" git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Taglist
Plug 'majutsushi/tagbar'
" AutoCompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" }}}
" ------------------------------------------------------------------------
" ------------------------------------------------------------------------
" Plugin-Navigation{{{
"" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 0 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

"  ====
"  }}}

" Plugin-fugitive-git {{{
nnoremap <leader>Git :Git

" }}}
" 
" Plugin-vim-airline {{{
" }}}
" 
" Plugin-Taglist {{{
nmap <leader>ll :TagbarToggle<cr>
"
"}}}

" Plugin-nerdtree {{{
nnoremap <leader>nt :NERDTreeToggle<CR>
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" }}}

" Plugin-coc.vim{{{
"  ====
"  COC CONFIG
"  ====
" TextEdit might fail if hidden is not set.
set hidden
" Having longer updatetime (default is 3999 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=99
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-1.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <M-space> coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= -1)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(-1) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(-1)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(-1) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=-1 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=-1 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" 
" note ； Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"  ====
"  COC CONFIG
"  ====
"}}}

" General {{{
set nocompatible
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
"设置备份文件存放位置
silent !mkdir -p $HOME/AppData/Local/nvim/tmp/backup
silent !mkdir -p $HOME/AppData/Local/nvim/tmp/undo
"silent !mkdir -p $HOME/AppData/Local/nvim/tmp/sessions
set backupdir=$HOME/AppData/Local/nvim/tmp/backup,.
set directory=$HOME/AppData/Local/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/AppData/Local/nvim/tmp/undo,.
endif

" }}}

" GUI {{{
"colorscheme evening
colorscheme snazzy
set cursorline
set hlsearch
set number
set relativenumber
set scrolloff=5
" 窗口大小
set lines=35 columns=140
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
set nolist
"set listchars=tab:?\ ,eol:?,trail:·,extends:>,precedes:<
"set guifont=JetBrains_Mono:20
set guifont=JetBrains_Mono:h19:cANSI
" }}}

" Format {{{
set autoindent
set smartindent
set ignorecase
set smartcase
set tabstop=4
set expandtab
set shiftwidth=2
set softtabstop=4
set shortmess+=c
syntax on
augroup ft_vim
    autocmd!
    autocmd Filetype python setlocal foldmethod=indent
    autocmd Filetype c setlocal foldmethod=marker
    autocmd FileType vim setlocal foldmethod=marker
augroup end

"autocmd FileType python set omnifunc=pythoncomplete#Complete
" }}}

" Keymap {{{
"-------------------NORMAL MODE-----------------------------
nmap <leader>s :source ~/AppData/Local/nvim/init.vim<cr>
nmap <leader>w :w<cr>
nmap <leader>e :e ~/AppData/Local/nvim/init.vim<cr>
nmap <leader>wq :wq<cr>
nmap <leader>q :q<cr>
nmap <leader>help :help<space>
nmap <leader>h :help<space>
"标签页管理 
"
map <space><cr> :nohl<cr>
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>th :tabpre<cr>
map <leader>tl :tabnext<cr>
map <leader>to :tabonly<cr>
" 分割窗口管理
noremap <leader>sl :set splitright<CR>:vsplit<CR>
noremap <leader>sh :set nosplitright<CR>:vsplit<CR>
noremap <leader>sk :set nosplitbelow<CR>:split<CR>
noremap <leader>sj :set splitbelow<CR>:split<CR>
" 移动分割窗口
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
 
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-k> :resize +5<cr>
nnoremap <M-j> :resize -5<cr>
nnoremap <M-l> :vertical resize -5<cr>
nnoremap <M-h> :vertical resize +5<cr>
" 快速移动 shift + 方向键
nnoremap <S-k> 3k
nnoremap <S-j> 3j
" goto mark位置
nnoremap gm g`
 
" 打印当前时间
map <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
 
" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
" 设置行号显示 
nnoremap <F2> :setlocal relativenumber!<cr>
" 设置切换Buffer快捷键"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
"选择当前行 
nnoremap vv ^vg_
" 重复上次操作
nnoremap U <C-r>
nnoremap <leader>sav :saveas<Space>

"-------------------INSERT MODE-----------------------------
" 插入模式移动光标 alt + 方向键
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
inoremap jj <Esc>
"复制当前行到下一行
inoremap <C-d> <esc>"xyy<CR>"xP<CR>2k<CR>i
" 删除前一个Word
inoremap <C-BS> <Esc>bdei
imap <C-V>		"+gP
" 转换当前word行为大写
inoremap <C-u> <esc>mzgUiw`za
imap <C-v> "+gP

"-------------------VISUAL MODE-----------------------------
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y 


"-------------------COMMAND MODE-----------------------------
map <S-Insert>		"+gP
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>
cmap <C-v>		<C-R>+
cmap <S-Insert>		<C-R>+ 
" 常规操作-复制、黏贴、选择 CO/PY CUT PASTE SELETED
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!gcc % -o %<"
                exec "AsyncRun -raw %<"
                exec "copen"
                exec "wincmd p" 
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'python'
            if search("@profile")
                exec "AsyncRun kernprof -l -v %"
                exec "copen"
                exec "wincmd p"
            elseif search("set_trace()")
                exec "!python %"
            else
                exec "AsyncRun -raw python %"
                exec "copen"
                exec "wincmd p"
            endif
        elseif &filetype == 'markdown'
                "exec "!~/.vim/markdown.pl % > %.html &"
                "exec "!google chrome %.html &"
                exec "MarkdownPreview"
        endif
endfunc

map <F4> :call CodeFormatter()<CR>
func! CodeFormatter()
        exec "w"
        if &filetype == 'markdown'
                exec "TableFormat"
        endif
endfunc
"}}}

