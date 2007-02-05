" {{{1  Documentation
" Version: $Id: autoloadTemplate.vim,v 1.2 2007/02/06 05:22:55 alanc Exp $
" File: autoloadTemplate.vim
" Maintainer: Alan Che <alan.che@hotmail.com>
" Last Change:2007/02/06
" 
" {{{2  Decription: 
"
"   Load template file from a specific directory according their filetype while
"   starting to edit a new file. if the file does not exist, skip it!
"
"
" {{{2  INSTALL:
"   Here is the way to install this script to your site:
"     1. extract this file to ~/.vim/plugin
"     2. create a directory ~/.vim/template
"     3. create your template files in that directory, where the file name follow
"   th rule:
"      <filetype>.vim
"      where <filetype> is the filetype of this template will apply to, such
"      as: verilog.vim, tcl.vim and so on.
"
"
" {{{1 Source code



let g:TemplatePath="~/.vim/template"

augroup loadTemplate
    autocmd!
    au FileType *  call Template()

    function! Template()
	if ! exists("b:IsNewFile")
	    return
	endif

	if exists("b:Template_loaded")
	    return 
	endif
	let b:Template_loaded=1

	let b:ThisFileType=expand("<amatch>")
	let b:TemplatePath=g:TemplatePath ."/". b:ThisFileType . ".vim"
	let TemplateFullName = expand(b:TemplatePath)

	if filereadable(TemplateFullName)
	    let $TemplateFullName=TemplateFullName
	    0r $TemplateFullName
	    unlet TemplateFullName
	    normal G
	endif
    endfunction

augroup END

au BufNewFile  * execute "let b:IsNewFile=1"
au BufNewFile  * execute "doau loadTemplate FileType"


" vim: set ft=vim foldmethod=marker sw=4 ts=8: