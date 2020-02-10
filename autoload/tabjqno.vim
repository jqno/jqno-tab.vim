function! tabjqno#complete()
    if pumvisible()
        return "\<C-N>"
    endif

    let l:substr = tabjqno#wordtocomplete()

    let l:only_whitespace = strlen(l:substr) == 0
    if (l:only_whitespace)
        return "\<Tab>"
    endif

    let l:has_slash = match(l:substr, '\/') != -1
    let l:has_html_slash = match(l:substr, '<\/') != -1
    if (l:has_slash && !l:has_html_slash)
        return "\<C-X>\<C-F>"
    endif

    if exists('g:did_plugin_ultisnips') && !empty(UltiSnips#SnippetsInCurrentScope(0))
        return "\<C-R>=tabjqno#ulticomplete()\<CR>"
    endif

    if exists('&omnifunc') && &omnifunc !=# ''
        return "\<C-X>\<C-O>"
    endif

    return "\<C-X>\<C-P>"
endfunction


function! tabjqno#ulticomplete() abort
    " Inspired by https://github.com/SirVer/ultisnips/issues/886
    let l:word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let l:contain_word = 'stridx(v:val, l:word_to_complete)>=0'
    let l:candidates = map(filter(keys(g:current_ulti_dict), l:contain_word),
        \  "{
        \      'word': v:val,
        \      'menu': '[snip] '. g:current_ulti_dict[v:val],
        \      'dup' : 1,
        \   }")
    let l:from_where = col('.') - len(l:word_to_complete)
    if !empty(l:candidates)
        call complete(l:from_where, l:candidates)
    endif
    return ''
endfunction

function! tabjqno#accept() abort
    return pumvisible() ? "\<C-Y>\<C-R>=tabjqno#ultiaccept()\<CR>" : "\<CR>"
endfunction

function! tabjqno#ultiaccept() abort
    let l:wordtocomplete = tabjqno#wordtocomplete()
    if has_key(UltiSnips#SnippetsInCurrentScope(0), l:wordtocomplete)
        return "\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
    endif
    return ''
endfunction

function! tabjqno#wordtocomplete() abort
    let l:line = getline('.')
    let l:substr = strpart(l:line, 0, col('.'))
    return matchstr(l:substr, '\S*$')
endfunction

