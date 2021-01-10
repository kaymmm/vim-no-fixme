"
" Filename: autoload/nofixme.vim
" Author: Keith Miyake
" Author: fisle
" License: MIT License
"

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:tags = get(g:, 'nofixme_tags',
      \ 'TODO\|FIXME\|XXX\|' .
      \ '\\reference\|\\todo\|\\info\|\\fixme\|\\XXX\|\\unsure')

function! nofixme#amount(...) abort
  if !&modifiable
      return ''
  endif

  let l:tag = get(a:, 1, s:tags)
  let l:pos = stridx(l:tag, '\|')
  let l:label = l:pos > -1 ? strpart(l:tag, 0, l:pos) : l:tag
  let l:label = substitute(l:label, '\\', '', 'g')
  let l:count = s:count(l:tag)
  return l:count > 0 ? l:label . l:count : ''
endfunction

function! s:count(tag) abort
  let s:c = []
  call map(getline(0, line('$')), { k,v -> substitute(v, a:tag, '\=add(s:c, v)[-1]', 'g')})
  return len(s:c)
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
