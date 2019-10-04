" Install `vim-plug`
" https://github.com/junegunn/vim-plug
" 
" Then type `:PlugInstall` and press Enter

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site')

" --- Recommended Neovim plugins ---
Plug 'vim-airline/vim-airline'
" File System explorer
" Note: using the command `:Ex` might be better...?
Plug 'scrooloose/nerdTree'
" Install fuzzy-finder
Plug 'junegunn/fzf.vim'

" Install bash commands
Plug 'https://github.com/tpope/vim-eunuch'

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

" --- Haskell / PureScript LSP plugins ----
" Coc plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" PureScript language completion
Plug 'https://github.com/purescript-contrib/purescript-vim'
" Color theme designed for Haskell / PureScript
Plug 'NLKNguyen/papercolor-theme'

" --- Miscellaneous Plugins ---
" completion tool for web languages
Plug 'mattn/emmet-vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" These configurations were selectively taken from
" https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/
" ------------- Start --------------
"
" --- Indent Options ---
set autoindent
set expandtab
filetype plugin indent on
set smarttab
set tabstop=2
set shiftround
set shiftwidth=2

" --- Search Options ---
set hlsearch
set ignorecase
set incsearch
set smartcase

" --- Performance Options ---
set lazyredraw

" --- Text Rendering Options ---
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap

" --- User Interface options ---
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
" colorscheme is set elsewhere based on language used
" background is set elsewhere based on language used
set cursorline
set wildmenu
set number
" set relativenumber " didn't use
set noerrorbells
set mouse=a
set title

" --- Code Folding Options ---
set foldmethod=indent
set foldnestmax=8
set nofoldenable

" --- Miscellaneous Options ---
set autoread
set backspace=indent,eol,start
set confirm
set formatoptions+=j
set hidden
set history=1000
" Note: backup-related options were not set

" --- Spelling Options ---
" Enable spell checker for en_US using neovim's configuration
setlocal spell spelllang=en

" ---------- End ------------

" --- Other Options ---

" Show matching brackets
set showmatch

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Enables pasting in from outside of Neovim
set clipboard=unnamedplus

" Shows the commands one has written (e.g. d2w) at bottom-right while
" inputting it 
set showcmd

" Use dark themed color scheme specific to Haskell and PureScript
set background=dark
colorscheme PaperColor

" Coc.vim specific configuration that aren't already covered by above
" https://github.com/neoclide/coc.nvim#example-vim-configuration
"
" ---------- Start of Coc.vim -----------------

" if hidden is not set, TextEdit might fail.
" set hidden " already covered above

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
noremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>n

" ------ End of Coc.vim configuration ---------
