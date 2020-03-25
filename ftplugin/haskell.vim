setlocal tabstop=2 softtabstop=2 shiftwidth=2
setlocal textwidth=80
setlocal colorcolumn=81,121

" Change "a (function application)" to "a $ function application"
nnoremap <buffer> <Leader>$ :normal dsbi$<Space><CR>

" Split (Constraint) => Type -> Type across multiple lines:
" func :: (Constraint)
"   => Type
"   -> Type
" (note: this is hacky and not very flexible)
nnoremap <Leader>HS :s/\zs<Space>\ze[=-]><Space>/\r<Space><Space>/g<CR>

" Generate hasktags
command! HaskTags execute "!hasktags --ctags ."

let g:hs_exts = ['AllowAmbiguousTypes', 'ApplicativeDo', 'Arrows', 'BangPatterns', 'BinaryLiterals', 'BlockArguments', 'CApiFFI', 'ConstrainedClassMethods', 'ConstraintKinds', 'CPP', 'CUSKs', 'DataKinds', 'DatatypeContexts', 'DefaultSignatures', 'DeriveAnyClass', 'DeriveDataTypeable', 'DeriveFoldable', 'DeriveFunctor', 'DeriveGeneric', 'DeriveLift', 'DeriveTraversable', 'DerivingStrategies', 'DerivingVia', 'DisambiguateRecordFields', 'DuplicateRecordFields', 'EmptyCase', 'EmptyDataDecls', 'EmptyDataDeriving', 'ExistentialQuantification', 'ExplicitForAll', 'ExplicitNamespaces', 'ExtendedDefaultRules', 'FlexibleContexts', 'FlexibleInstances', 'ForeignFunctionInterface', 'FunctionalDependencies', 'GADTs', 'GADTSyntax', 'GeneralisedNewtypeDeriving', 'Haskell2010', 'Haskell98', 'HexFloatLiterals', 'ImplicitParams', 'ImplicitPrelude', 'ImportQualifiedPost', 'ImpredicativeTypes', 'IncoherentInstances', 'InstanceSigs', 'InterruptibleFFI', 'KindSignatures', 'LambdaCase', 'LiberalTypeSynonyms', 'MagicHash', 'MonadComprehensions', 'MonadFailDesugaring', 'MonoLocalBinds', 'MonomorphismRestriction', 'MultiParamTypeClasses', 'MultiWayIf', 'NamedFieldPuns', 'NamedWildCards', 'ndecreasingIndentation', 'NegativeLiterals', 'NPlusKPatterns', 'NullaryTypeClasses', 'NumDecimals', 'NumericUnderscores', 'OverlappingInstances', 'OverloadedLabels', 'OverloadedLists', 'OverloadedStrings', 'PackageImports', 'ParallelListComp', 'PartialTypeSignatures', 'PatternGuards', 'PatternSynonyms', 'PolyKinds', 'PostfixOperators', 'QuantifiedConstraints', 'QuasiQuotes', 'Rank2Types', 'RankNTypes', 'RebindableSyntax', 'RecordWildCards', 'RecursiveDo', 'RoleAnnotations', 'Safe', 'ScopedTypeVariables', 'StandaloneDeriving', 'StandaloneKindSignatures', 'StarIsType', 'StaticPointers', 'Strict', 'StrictData', 'TemplateHaskell', 'TemplateHaskellQuotes', 'TraditionalRecordSyntax', 'TransformListComp', 'Trustworthy', 'TupleSections', 'TypeApplications', 'TypeFamilies', 'TypeFamilyDependencies', 'TypeInType', 'TypeOperators', 'TypeSynonymInstances', 'UnboxedSums', 'UnboxedTuples', 'UndecidableInstances', 'UndecidableSuperClasses', 'UnicodeSyntax', 'UnliftedFFITypes', 'UnliftedNewtypes', 'Unsafe', 'ViewPatterns']

function! s:CompleteHsLanguageExts(A, L, P) abort
    let exts = g:hs_exts[:]
    call filter(exts, 'v:val =~? a:A')
    return exts
endfunction

function! s:InsertExt(ext) abort
    if !empty(trim(a:ext))
        let ln = 1
        let lastline = line('$')
        " Skip shebangs
        while ln <= lastline && getline(ln) =~# '#!'
            let ln += 1
        endwhile
        call append(ln - 1, '{-# language ' . a:ext . ' #-}')
        " Append blank line if module comes right after language extension
        if getline(ln + 1) =~# 'module'
            call append(ln, '')
        endif
    endif
endfunction

" Prompt for and insert a language extension at the top of the current buffer
command! -nargs=1 -complete=customlist,<SID>CompleteHsLanguageExts Ext call <SID>InsertExt(<q-args>)

