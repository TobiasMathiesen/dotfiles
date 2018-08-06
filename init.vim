" Custom
set number
set expandtab
set tabstop=4
set shiftwidth=4

" Clear search highlight on <esc>
nnoremap <silent> <esc> :noh<cr><esc>

" <F4> to save file + cargo build
nnoremap <F4> :w <CR> :!cargo build<CR>
" <F5> to save file + cargo run
nnoremap <F5> :w <CR> :!cargo run<CR>

" Copy to buffer
vmap <C-c> :w! ~/.vimbuffer<CR>
nmap <C-c> :.w! ~/.vimbuffer<CR>
"Paste from buffer
map <C-p> :r ~/.vimbuffer<CR>

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'itchyny/lightline.vim'
Plug 'markonm/traces.vim'  
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'

call plug#end()

" Rust RLS
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufReadPost *.rs setlocal filetype=rust
set completeopt=noinsert,menuone,noselect
au TextChangedI * call ncm2#auto_trigger()

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
nnoremap <silent> K :call LanguageClient_textDocument_hover()
nnoremap <silent> gd :call LanguageClient_textDocument_definition()
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <TAB> ncm2_ultisnips#expand_or("\<TAB>", 'n')


" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" Activate color scheme
colorscheme jellybeans
