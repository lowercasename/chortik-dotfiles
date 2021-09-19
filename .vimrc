" RAPHAEL'S GOOD VIMRC
" Copyleft 2021: All Wrongs Reserved
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins required/desired:
" Lightline <https://github.com/itchyny/lightline.vim>
" Apprentice <https://github.com/romainl/Apprentice>
" Surround <https://github.com/tpope/vim-surround>
" Commentary <https://github.com/tpope/vim-commentary>
" Pear-tree <https://github.com/tmsvg/pear-tree>
" Vim-pencil <https://github.com/preservim/vim-pencil>
" Vim-wheel <https://github.com/preservim/vim-wheel>
" 
" Other desired tools:
" ripgrep, fzf

" 1. GENERAL CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make plugins work
filetype plugin indent on

" Save swap files in a temp directory
set directory^=$HOME/.vim/tmp/

" Enable mouse
set mouse=a
set ttymouse=sgr

" Autoreload changed files
set autoread

" Map escape sequences to <A-letter> combinations
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw
" Timeout to distinguish <A-letter> from <ESC>letter
set timeout ttimeoutlen=50

" Set leader to the comma key
let mapleader = ","

" 2. DISPLAY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General display options
set number
syntax on

" Color scheme

" Enable italics for the pencil colorscheme
let g:pencil_terminal_italics = 1

" If needed, uncomment these lines to make colors
" work in Alacritty
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"
set background=dark
colorscheme hedgewitch

" Enable cursorline in Insert mode
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Change cursor in Insert mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" Lightline
set laststatus=2
" - Hide mode from second status bar
set noshowmode
" - Lightline colorscheme
let g:lightline = {
    \ 'colorscheme': 'apprentice',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ],
    \             [ 'vim-pencil' ]
    \           ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent', 'wordcount' ],
    \              [ 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'vim-pencil': 'PencilMode',
    \   'wordcount': 'WordCount',
    \ }
    \ }

" 3. TEXT ENTRY AND NAVIGATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab characters count for 8 spaces 
" (This is a default, and is good for noticing sneaky tabs)
set tabstop=8
" Indent by 4 spaces
set shiftwidth=4
" Replaces tabs with spaces (Ctrl-V<TAB> to type actual tab)
set expandtab
" Turns on autoindent
set autoindent
" Usually tabs to the right location
set smartindent
" Print shiftwidth number of spaces when tabbing
set smarttab

" Make backspace work predictably
set backspace=indent,eol,start

" Consider hyphens as a part of inner words
" (+= adds a symbol, -= removes it)
set iskeyword+=-

" Shift lines up and down with Alt-J and Alt-K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Keep visual mode on after indenting
vnoremap > >gv^
vnoremap < <gv^

" 4. SEARCHING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow case-insensitive and case-smart searches
set ignorecase
set smartcase

inoremap <A-j> <Esc>:m .+1<CR>==gi
" Show number of matching search results in the statusline
set shortmess-=S

" Highlight search results
set hlsearch

" Clear search highlighting by hitting Return
nnoremap <CR> :noh<CR><CR>

" 5. UI - BUFFERS, TABS, WINDOWS, PANES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enhanced tab-completion
set wildmenu

" Hide buffers instead of closing them on buffer switch
set hidden

" Buffer navigation shortcuts
nnoremap gb :ls<CR>:b<Space>
nnoremap <PageUp> :bprevious<CR>
nnoremap <PageDown> :bnext<CR>

" 6. FZF 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf

" Open FZF with leader-F
nnoremap <leader>f :FZF<CR>

" 7. RIPGREP 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open ripgrep entries in new tab with C-t
augroup quickfix_tab | au!
    au filetype qf nnoremap <buffer> <C-t> <C-w><CR><C-w>T
augroup END

" Open ripgrep with leader-R
nnoremap <leader>r :Rg 

" 8. SESSIONS 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save and restore session
command Save :mksession! ~/.vimsession <CR>
command Load :source ~/.vimsession <CR>

" Save and load sessions with leader-s and leader-l
nnoremap <leader>s :Save<CR>
nnoremap <leader>l :Load<CR>

" 9. PEAR-TREE 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable the dot-repeatable pair expansion feature
let g:pear_tree_repeatable_expand = 0

" 10. MISCELLANEOUS SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source .vimrc file
command Source :source ~/.vimrc

" Source .vimrc with leader-o
nnoremap <leader>o :Source<CR>

" Console log from Insert mode; puts focus inside parentheses
" The Ctrl-V prevents the bracket autocloser from autoclosing
imap cll console.log<C-v>();<Esc><S-f>(a
" Console log from visual mode on next line;
" puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from Normal mode, inserted on next line with
" word under cursor inside parentheses
nmap cll yiwocll<Esc>p

" 11. FILETYPES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the filetype based on the file's extension, but only if
" " 'filetype' has not already been set
au BufRead,BufNewFile *.twig set filetype=html
au BufRead,BufNewFile *.html.twig set filetype=html

" 12. VIM-PENCIL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle vim-pencil with leader-p
nnoremap <leader>p :PencilToggle<CR>

" Set custom vim-pencil indicators
let g:pencil#mode_indicators = {'hard': 'פֿ', 'auto': 'פֿ', 'soft': '﬋', 'off': '',}

" Good word count function
function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction
