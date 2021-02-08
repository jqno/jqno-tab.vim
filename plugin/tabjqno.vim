if exists('g:loaded_jqno_tab')
    finish
endif
let g:loaded_jqno_tab = 1

if empty(maparg('<Tab>', 'i'))
    inoremap <expr><silent> <Tab> tabjqno#complete()
endif
if empty(maparg('<S-Tab>', 'i'))
    inoremap <expr><silent> <S-Tab> tabjqno#shifttab()
endif

if empty(maparg('<CR>', 'i'))
    if exists('g:loaded_jqno_autoclose')
        inoremap <expr><silent> <CR> pumvisible() ? tabjqno#accept() : JqnoAutocloseSmartReturn()
    else
        inoremap <expr><silent> <CR> tabjqno#accept()
    endif
endif
