" system
set backup
set backupdir=$HOME/.vimbackup,$HOME/vimfiles/backup
let &directory = &backupdir
set clipboard+=unnamed
set hidden
set virtualedit=block
set whichwrap=b,s,[,],<,>
"set noautoindent
"set nosmartindent
"set nocindent

" search
set ignorecase
set smartcase
set wrapscan
set incsearch
set nohlsearch

" display
syntax on
set number
set columns=140
set lines=50

"set encoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
"
set autochdir

set noshowmatch
set guicursor=a:blinkon0

" マウスを無効にする
set mouse=

" 右側のスクロールバーを無効にする
set guioptions-=r

" mac gvim の設定
if has('mac')
	colorscheme solarized
	set background=light
elseif has('windows')
	colorscheme wombat256mod
	set gfn=MS_Gothic:h10:cSHIFTJIS
	cd C:\Users\ss-yamashita\Documents

	" use scp
	let g:netrw_cygwin = 1
	set mouse=
endif
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

function! s:BufcloseCloseIt(bang)
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")
	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif
	if bufnr("%") == l:currentBufNum
		if a:bang == '!' || &modified==0
			new
		endif
	endif
	if buflisted(l:currentBufNum)
		execute "silent bwipeout".a:bang l:currentBufNum
		if bufloaded(l:currentBufNum) != 0
			execute "buffer" l:currentBufNum
		endif
	endif
endfunction
command! -bang Bdelete call s:BufcloseCloseIt("<bang>")
command! -bang BDelete call s:BufcloseCloseIt("<bang>")
function! s:Javac()
	:w
	let l:path=expand("%")
	"let l:syn="javac ".l:path
	let l:syn="javac -J-Dfile.encoding=UTF-8 ".l:path
	"let l:syn="source ~/.bashrc; javac ".l:path
	let l:dpath=split(l:path,".java$")
	let l:ret=system(l:syn)
	if l:ret==""
		"let l:syn="java ".l:dpath[0]
		let l:syn="java -Dfile.encoding=UTF-8 ".l:dpath[0]
		"let l:syn="source ~/.bashrc; java ".l:dpath[0]
		let l:ret=system(l:syn)
		echo "$ ".l:syn."\r\n".l:ret
	else
		echo l:ret
	endif
endfunction
command! Javac call s:Javac()
function! s:Gcc()
	:w
	let l:path=expand("%")
	let l:syn="gcc-3 ".l:path
	let l:ret=system(l:syn)
	if l:ret==""
		let l:syn="a.exe"
		let l:ret=system(l:syn)
		echo "$ ".l:syn."\r\n".l:ret
	else
		echo l:ret
	endif
endfunction
command! Gcc call s:Gcc()

