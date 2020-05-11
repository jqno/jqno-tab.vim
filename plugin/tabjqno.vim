if exists('g:loaded_jqno_tab')
    finish
endif
let g:loaded_jqno_tab = 1

inoremap <expr><silent> <Tab> tabjqno#complete()
inoremap <expr><silent> <S-Tab> tabjqno#shifttab()

if exists('g:loaded_jqno_autoclose')
    inoremap <expr><silent> <CR> pumvisible() ? tabjqno#accept() : JqnoAutocloseSmartReturn()
else
    inoremap <expr><silent> <CR> tabjqno#accept()
endif
