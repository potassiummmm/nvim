let $NVIM_COC_LOG_LEVEL='all'

" === 
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Editor behavior
" ===

" set termguicolors
set number
set relativenumber
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2
set fileencoding=utf-8
set encoding=utf-8
set splitright
set splitbelow
set scrolloff=10
set showcmd
set ignorecase
set smartcase
set clipboard=unnamedplus
set autochdir
set hidden
set mouse=

exec "nohlsearch"

let mapleader=" "
noremap ; :
nnoremap <LEADER>e :CocCommand explorer<CR>
noremap Q :q<CR>
noremap S :w<CR>


" Tab management
noremap tu :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" Window management
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
noremap <LEADER>p <C-w>p
noremap <up> :res -5<CR>
noremap <down> :res +5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Function preview
noremap <LEADER>g :LeaderfFunction!<CR>

" Faster movement
noremap qf <C-w>o
noremap H 5h
noremap J 5j
noremap K 5k
noremap L 5l

" Press space+/ to open terminal
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" ESC remapped
inoremap jk <ESC>l
inoremap JK <ESC>l

" Cursor movement in insert mode
inoremap <C-a> <ESC>A

" Cursor movement in command mode
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>


" Quicker indent
nnoremap < <<
nnoremap > >>



" ===
" === Coc.nvim Configuration
" ===

" coc.nvim extensions
let g:coc_global_extensions = [
	\ 'coc-snippets',  
	\ 'coc-explorer',  
	\ 'coc-sh',
	\ 'coc-diagnostic',  
	\ 'coc-syntax',  
	\ 'coc-translator',
	\ 'coc-rust-analyzer',
	\ 'coc-pyright',
	\ 'coc-vimlsp', 
    \ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-json',
	\ 'coc-clangd',
	\ 'coc-yank']


" Press Tab to Choose the First Snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use control + space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" Format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>rn <Plug>(coc-rename)

" Coc-snippets Configuration
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" coc-translator
nmap ts <Plug>(coc-translator-p)
vmap ts <Plug>(coc-translator-pv)

" == Markdown Snippets Settings
source ~/.config/nvim/md-snippets.vim

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'

" Press F10 to Show hlgroup
function! SynGroup()
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	if &bt != 'nofile'
		exec "w"
	endif
	if &filetype == 'c'
		set splitbelow
		exec "!gcc % -Wall -o %<"
		:sp
		:term ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++14 % -Wall -o %<"
		:sp
		:term ./%<
    elseif &filetype == 'java'
		set splitbelow
		exec "!javac %" 
		exec "!time java %<"
    elseif &filetype == 'sh'
		:!time zsh %
	elseif &filetype == 'javascript'
		exec '!node %'
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'cs'
		:!dotnet run
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	elseif &filetype == 'rust'
		:!cargo run
	endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')


" Snippets
Plug 'honza/vim-snippets'


" Function and Variable List
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'liuchengxu/vista.vim'

Plug 'airblade/vim-rooter'


" Interface Beautify
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'wincent/terminus'
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
" Plug 'theniceboy/eleline.vim'
" Plug 'ojroques/vim-scrollstatus'


" Auto Compeletion and Plugin Market
Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Simplify Operation
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround' 
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'gcmt/wildfire.vim' 

" File Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


" Markdown
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


" Quick Comment
Plug 'tomtom/tcomment_vim' 


" Git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'kdheepak/lazygit.nvim'
"Plug 'mhinz/vim-signify'


" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'


" LaTeX
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }


" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" Nvim tree
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'

" LeetCode
" Plug 'potassiummmm/coc-leetcode', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug '~/Desktop/Repo/coc-leetcode'

" Swift
Plug 'keith/swift.vim'
Plug 'arzg/vim-swift'

Plug 'laishulu/vim-macos-ime'

" Rust
Plug 'rust-lang/rust.vim'

" Copilot
Plug 'github/copilot.vim'

call plug#end()


" Beautify Configuration
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
" set background=light
" colorscheme solarized
set background=dark
" colorscheme gruvbox
" colorscheme dracula
colorscheme deus
hi HighlightedyankRegion cterm=bold gui=bold ctermbg=0 guibg=#afc5cb


" ===
" === vim-airline
" ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" ===
" === Rainbow
" ===
let g:rainbow_active = 1


" ===
" === Ultisnips
" ===
" let g:UltiSnipsExpandTrigger="<c-d>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" ===
" === coc-yank
" ===
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


" ===
" === coc-snippets
" ===
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)



" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl




" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
"let g:table_mode_disable_mappings = 1



" ===
" === Bullets.vim
" ===
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]



" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'



" ===
" === wincent/terminus
" ===
let g:TerminusMouse=0



" ===
" === vimtex
" ===
let g:tex_flavor='latex'
autocmd Filetype tex setl updatetime=5
let g:livepreview_previewer = 'open -a Preview'
let g:vimtex_view_method = 'skim' 
let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}



" ===
" === Leaderf
" ===
let g:Lf_ShowDevIcons = 1
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
let g:Lf_NormalMap = {
	\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }



" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>



" ===
" === vim-go
" ===
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0



" ===
" === Autoformat
" ===
augroup autoformat_settings
  " autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,arduino AutoFormatBuffer clang-format
  " autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,javascript,scss,less,json AutoFormatBuffer js-beautify
  " autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType rust AutoFormatBuffer rustfmt
  " autocmd FileType vue AutoFormatBuffer prettier
augroup END



" ==
" == GitGutter
" ==
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
" let g:gitgutter_sign_added = '▎'
" let g:gitgutter_sign_modified = '░'
" let g:gitgutter_sign_removed = '▏'
" let g:gitgutter_sign_removed_first_line = '▔'
" let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
" nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>



" ===
" === coc-gitignore
" ===
noremap <LEADER>gi :CocList gitignore<CR>



" ===
" === Agit
" ===
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1



" ===
" === lazygit.nvim
" ===
noremap <c-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " for neovim-remote support



" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['=Src', '=src', '__vim_project_root', '.git/', '*.sln', 'Makefile']
let g:rooter_silent_chdir = 0



" ===
" === coc-leetcode
" ===
noremap <LEADER>ll :CocList LeetcodeProblems<CR>
noremap <LEADER>lr :CocCommand leetcode.run<CR>
noremap <LEADER>ls :CocCommand leetcode.submit<CR>
noremap <LEADER>lc :CocCommand leetcode.comments<CR>


" ===
" === Vista.vim
" ===
noremap <LEADER>v :Vista!!<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }


" ===
" === tcomment_vim
" ===
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>c gcc
vmap <LEADER>c gc


" ===
" === FZF
" ===
nnoremap <c-p> :Leaderf file<CR>
noremap <LEADER>f :Files<CR>
noremap <silent> <C-f> :Ag<CR>
noremap <silent> <C-h> :History<CR>
noremap <silent> <C-w> :Buffers<CR>

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

let g:startify_custom_header = startify#pad(split(system('figlet -w 100 NEOVIM'), '\n'))

function! ReplaceChineseCharacter()
	execute "%s/（/(/g"
	execute "%s/）/)/g"
	execute "%s/，/,/g"
	execute "%s/。/./g"
	execute "%s/：/:/g"
	execute "%s/；/;/g"
	execute "%s/“/\"/g"
	execute "%s/”/\"/g"
endfunction

autocmd FileType markdown,cpp autocmd BufWritePre <buffer> silent! call ReplaceChineseCharacter()

augroup HiglightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
augroup END


" ===
" === bullets.vim
" ===

" indent and unindent
" inoremap <C-l> <C-t>
" inoremap <C-h> <C-d>


" ===
" === markdown-preview.nvim
" ===

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 1
    \ }


noremap <LEADER>t :GenTocGFM<CR>


" Rust
let g:rustfmt_autosave = 1

" Copilot
let g:copilot_filetypes = {
	  \ '*': v:false,
	  \ 'cpp': v:false,
	  \ 'python': v:true,
	  \ }

