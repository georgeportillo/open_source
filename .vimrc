execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark
colorscheme onedark
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

filetype indent on
set number
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set hlsearch
set undofile
set runtimepath^=~/.vim/bundle/ctrlp.vim

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:onedark_termcolors=256

let g:javascript_plugin_jsdoc = 1

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd BufWritePre * :%s/\s\+$//e

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')

if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif

if !exists("*InitBackupDir")
	function InitBackupDir()
		if has('win32') || has('win32unix') "windows/cygwin
			let separator = "_"
		else
			let separator = "."
		endif
		let parent = $HOME .'/' . separator . 'vim/'
		let backup = parent . 'backup/'
		let tmp = parent . 'tmp/'
		if exists("*mkdir")
			if !isdirectory(parent)
				call mkdir(parent)
			endif
			if !isdirectory(backup)
				call mkdir(backup)
			endif
			if !isdirectory(tmp)
				call mkdir(tmp)
			endif
		endif
		let missing_dir = 0
		if isdirectory(tmp)
			execute 'set backupdir=' . escape(backup, " ") . "/,."
		else
			let missing_dir = 1
		endif
		if isdirectory(backup)
			execute 'set directory=' . escape(tmp, " ") . "/,."
		else
			let missing_dir = 1
		endif
		if missing_dir
			echo "Warning: Unable to create backup directories: " . backup ." and " . tmp
			echo "Try: mkdir -p " . backup
			echo "and: mkdir -p " . tmp
			set backupdir=.
			set directory=.
		endif
	endfunction
	call InitBackupDir()
endif
