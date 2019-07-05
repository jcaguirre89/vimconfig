" Most comes from https://github.com/ronakg/dotfiles/blob/master/vim/vimrc

let python_highlight_all=1
syntax on
set encoding=utf-8
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
set nu
set autoindent
au FileType python setlocal formatprg=autopep8\ -

let g:mapleader = "\<Space>"

set splitbelow
set splitright

" New command to see changes to current unsaved buffer
command! DiffOrig rightbelow vertical new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis | wincmd l
nmap <leader><Space> :DiffOrig<CR>

function! ZoomToggle()
    if exists('t:zoomed') && t:zoomed
            execute t:zoom_winrestcmd
            let t:zoomed = 0
        else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
nnoremap <silent> <C-a> :call ZoomToggle()<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
" Disable because space is my leader key
" nnoremap <space> za

" spaces and tabs as symbols
set list
set showbreak=\\ 
set listchars=eol:$,trail:.,extends:>,precedes:<,tab:│·,nbsp:~

" File formats and config for each type and default
" Default
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=119
set fileformat=unix

" Python
au BufNewFile,BufRead *.py 
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=119 |
    \ set expandtab |
    \ set autoindent |
    \ set smarttab |
    \ set smartindent |
    \ set fileformat=unix

" Web
au BufNewFile,BufRead *.js,*.html,*.css 
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=119 |
    \ set autoindent |
    \ set smartindent |
    \ set smarttab |
    \ set fileformat=unix


"au FileType html,js,css call s:SetWebOptions()
"function! s:SetWebOptions()
"	set tabstop=2
"	set softtabstop=2
"	set softtabstop=2
"	set textwidth=119
"	set expandtab
"	set smarttab
"	set autoindent
"	set smartindent
"	set fileformat=unix
"endfunction

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" color palette config
"let g:gruvbox_italic=1
set termguicolors
"set background=dark
let ayucolor="mirage"
colorscheme ayu

" Airline config
let g:airline#extensions#tabline#enabled                      = 1
let g:airline#extensions#tabline#buffer_min_count             = 1
let g:airline#extensions#tabline#tab_min_count                = 1
let g:airline#extensions#tabline#buffer_idx_mode              = 1
let g:airline#extensions#tabline#buffer_nr_show               = 0
let g:airline#extensions#tabline#show_buffers                 = 1
let g:airline#extensions#branch#enabled                       = 1
let g:airline#extensions#ale#enabled                          = 1
let g:airline_powerline_fonts                                 = 1
let g:airline#extensions#tagbar#enabled                       = 1
let g:airline#extensions#whitespace#enabled       = 0
let g:airline#extensions#tabline#fnamemod         = ':t'
let g:airline_theme                               = 'onedark'
let g:airline_section_c                           = '%{fnamemodify(expand("%"), ":~:.")}'
let g:airline_section_x                           = '%{fnamemodify(getcwd(), ":t")}'
" Easier tab/buffer switching
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    endif

" Change cursor shape based on mode.
if has('nvim')
    "set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
    set t_ut=
    set gcr=a:blinkon0
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif

" fugitive (git) configs
nnoremap <C-d> :call ZoomToggle()<CR>:Gdiff<CR>
nnoremap <leader>g :Gstatus<CR> 

" ALE (linting) config
" Check Python files with flake8 and pylint.
"let b:ale_linters = ['flake8', 'pylint', 'mypy', 'eslint']
let g:ale_linters = {
\   'python': ['flake8', 'pylint', 'mypy'],
\   'javascript': ['eslint'],
\}
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
let g:ale_python_flake8_options = '--max-line-length=120'
let g:ale_python_pylint_options = '--max-line-length=120'
" Bind F8 to fixing
nmap <F8> <Plug>(ale_fix)
" This is currently not working as far as I know
let g:ale_python_mypy_executable = 'mypy'
let g:ale_python_mypy_options = '--warn-no-return --ignore-missing-imports --follow-imports=skip'
let g:ale_python_mypy_use_global = 0

nmap <silent> <leader><C-k> <Plug>(ale_previous_wrap)
nmap <silent> <leader><C-j> <Plug>(ale_next_wrap)

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" CtrlP configs
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" Ignore these files/dirs
" This apparently doesn't work when ctrlp_user_command is used. add these to the .agignore file instead
set wildignore+=*/tmp/*,*.so,*.swp,*.zip


" Re-map some keys (ctr-v and ctrl-t are used by cmder and I need it for v-splits
" :h g:ctrlp_prompt_mappings
" ctrl+c: vertical split; ctrl+x: horizontal split
let g:ctrlp_prompt_mappings = {   
    \ 'AcceptSelection("v")': ['<c-c>', '<RightMouse>'],
    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>'],
    \ }

" Set silver searcher as default for "grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

 function! GetVisualSelection()
     " https://stackoverflow.com/a/6271254/777247
     let [line_start, column_start] = getpos("'<")[1:2]
     let [line_end, column_end] = getpos("'>")[1:2]
     let lines = getline(line_start, line_end)
     if len(lines) == 0
         return ''
     endif
     let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
     let lines[0] = lines[0][column_start - 1:]
     return join(lines, "\n")
endfunction

function! Search(pattern, flags)
    if strlen(a:pattern) <= 2
        let search_pattern = input("Enter search term: ")
    else
        let search_pattern = a:pattern
    endif
    execute "silent grep! " . a:flags . " \"" . search_pattern . "\""
    botright copen
    execute "normal /" . search_pattern
endfunction

" whole word, smart case 
nnoremap <leader>vv :call Search(expand("<cword>"), "-w -S -F")<CR> 
" whole word, ignore case
nnoremap <leader>vi :call Search(expand("<cword>"), "-w -i -F")<CR>
" any part of word, smart case
nnoremap <leader>VV :call Search(expand("<cword>"), "-S -F")<CR>

" Visual mode mappings
vnoremap <leader>vv :call Search(GetVisualSelection(), "-w -S -F")<CR>
vnoremap <leader>vi :call Search(GetVisualSelection(), "-w -i -F")<CR>
vnoremap <leader>VV :call Search(GetVisualSelection(), "-S -F")<CR>
vnoremap <leader>VI :call Search(GetVisualSelection(), "-i -F")<CR>

" Prompt for search text
" Full word
nnoremap <leader>vp :call Search("", "-w -S")<CR> 
" Not necessarily the wole word (type Debt to search for DebtTransaction)
nnoremap <leader>vc :call Search("", "-S")<CR>

" Easier movement in visual mode
vnoremap > >gv
vnoremap < <gv

" Open quickfix window by default
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
    autocmd VimEnter        *     cwindow
augroup END

" Navigate search results
nmap <leader><C-N> :cn<CR>zv
nmap <leader><C-P> :cp<CR>zv

" YouCompleteMe configs
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>gd :YcmCompleter GetDoc<CR>

" ctags config
set tags=tags;/
if !empty($VIRTUAL_ENV)
        map <F11> :! ctags -R -f $VIRTUAL_ENV/tags $VIRTUAL_ENV/lib/python3.6/site-packages
	        set tags=$VIRTUAL_ENV/tags;,tags;
		endif

" Map :CtrlPTags: Search generated tags
nnoremap <leader>. :CtrlPTag<CR>

" TagBar configs
nnoremap <silent> <Leader>b :TagbarToggle<CR>
let g:tagbar_sort = 0

"Ctrl S F mappings 
" Open search box
nmap <C-F>f <Plug>CtrlSFPrompt
" Search for word under cursor
nmap <C-F>c <Plug>CtrlSFCwordExec
" Search for words selected in visual mode
vmap <C-F>c <Plug>CtrlSFVwordExec
" Window size
let g:ctrlsf_winsize = '25%'

" Emmet config
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascript.jsx EmmetInstall

" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
