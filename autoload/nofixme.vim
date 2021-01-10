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

  let s:tag = get(a:, 1, s:tags)
  let s:pos = stridx(s:tag, '\|')
  let s:label = s:pos > -1 ? strpart(s:tag, 0, s:pos) : s:tag

  return s:count(s:tag) . ' ' . s:label
endfunction

function! s:count(tag) abort
  let s:c = []
  call map(getline(0, line('$')), { k,v -> substitute(v, a:tag, '\=add(s:c, v)[-1]', 'g')})
  return len(s:c)
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
