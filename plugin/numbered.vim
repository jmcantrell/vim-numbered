" Filename:      numbered.vim
" Description:   Number a list of items.
" Maintainer:    Jeremy Cantrell <jmcantrell@gmail.com>
" Last Modified: Sun 2010-10-24 22:09:09 (-0400)

if exists("g:numbered_loaded")
    finish
endif

let g:numbered_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:Numbered(...) range
    let n = a:0 == 0 ? 1 : a:1
    for lnum in range(a:firstline, a:lastline)
        let line = getline(lnum)
        let match = matchstr(line, '\d\+')
        if strlen(match)
            let line = substitute(line, match, n, '')
        else
            let line = n.' '.line
        endif
        call setline(lnum, substitute(line, '\s\+$', '', ''))
        let n += 1
    endfor
endfunction

command! -bar -range -nargs=? Numbered :<line1>,<line2>call s:Numbered(<args>)

let &cpo = s:save_cpo
