if !exists('g:colors_name') || g:colors_name !=# 'everforest'
    finish
endif
if index(g:everforest_loaded_file_types, 'javascriptreact') ==# -1
    call add(g:everforest_loaded_file_types, 'javascriptreact')
else
    finish
endif
let s:configuration = everforest#get_configuration()
let s:palette = everforest#get_palette(s:configuration.background)
" ft_begin: html/markdown/javascriptreact/typescriptreact {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax {{{
call everforest#highlight('htmlH1', s:palette.red, s:palette.none, 'bold')
call everforest#highlight('htmlH2', s:palette.orange, s:palette.none, 'bold')
call everforest#highlight('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call everforest#highlight('htmlH4', s:palette.green, s:palette.none, 'bold')
call everforest#highlight('htmlH5', s:palette.blue, s:palette.none, 'bold')
call everforest#highlight('htmlH6', s:palette.purple, s:palette.none, 'bold')
call everforest#highlight('htmlLink', s:palette.none, s:palette.none, 'underline')
call everforest#highlight('htmlBold', s:palette.none, s:palette.none, 'bold')
call everforest#highlight('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call everforest#highlight('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call everforest#highlight('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call everforest#highlight('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call everforest#highlight('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call everforest#highlight('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Green
highlight! link htmlEndTag Blue
highlight! link htmlTagN OrangeItalic
highlight! link htmlTagName OrangeItalic
highlight! link htmlArg Aqua
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
" }}}
" ft_end
" ft_begin: javascript/javascriptreact {{{
" builtin: http://www.fleiner.com/vim/syntax/javascript.vim {{{
highlight! link javaScriptNull Aqua
highlight! link javaScriptIdentifier Orange
highlight! link javaScriptParens Fg
highlight! link javaScriptBraces Fg
highlight! link javaScriptGlobal Purple
highlight! link javaScriptMessage Yellow
highlight! link javaScriptFunction RedItalic
highlight! link javaScriptOperator Orange
highlight! link javaScriptMember Aqua
" }}}
" vim-javascript: https://github.com/pangloss/vim-javascript {{{
highlight! link jsThis Purple
highlight! link jsUndefined Aqua
highlight! link jsNull Aqua
highlight! link jsNan Aqua
highlight! link jsSuper Purple
highlight! link jsPrototype Purple
highlight! link jsFunction RedItalic
highlight! link jsGlobalNodeObjects PurpleItalic
highlight! link jsGlobalObjects Yellow
highlight! link jsArrowFunction Purple
highlight! link jsArrowFuncArgs Blue
highlight! link jsFuncArgs Blue
highlight! link jsObjectProp Aqua
highlight! link jsVariableDef Blue
highlight! link jsObjectKey Aqua
highlight! link jsParen Blue
highlight! link jsParenIfElse Blue
highlight! link jsParenRepeat Blue
highlight! link jsParenSwitch Blue
highlight! link jsParenCatch Blue
highlight! link jsBracket Blue
highlight! link jsBlockLabel Aqua
highlight! link jsFunctionKey Green
highlight! link jsClassDefinition Yellow
highlight! link jsDot Grey
highlight! link jsDestructuringBlock Blue
highlight! link jsSpreadExpression Purple
highlight! link jsSpreadOperator Green
highlight! link jsModuleKeyword Yellow
highlight! link jsObjectValue Blue
highlight! link jsTemplateExpression Yellow
highlight! link jsTemplateBraces Yellow
highlight! link jsClassMethodType Orange
" }}}
" yajs: https://github.com/othree/yajs.vim {{{
highlight! link javascriptEndColons Fg
highlight! link javascriptOpSymbol Orange
highlight! link javascriptOpSymbols Orange
highlight! link javascriptIdentifierName Blue
highlight! link javascriptVariable Orange
highlight! link javascriptObjectLabel Aqua
highlight! link javascriptObjectLabelColon Grey
highlight! link javascriptPropertyNameString Aqua
highlight! link javascriptFuncArg Blue
highlight! link javascriptIdentifier Purple
highlight! link javascriptArrowFunc Purple
highlight! link javascriptTemplate Yellow
highlight! link javascriptTemplateSubstitution Yellow
highlight! link javascriptTemplateSB Yellow
highlight! link javascriptNodeGlobal PurpleItalic
highlight! link javascriptDocTags PurpleItalic
highlight! link javascriptDocNotation Purple
highlight! link javascriptClassSuper Purple
highlight! link javascriptClassName Yellow
highlight! link javascriptClassSuperName Yellow
highlight! link javascriptBrackets Fg
highlight! link javascriptBraces Fg
highlight! link javascriptLabel Purple
highlight! link javascriptDotNotation Grey
highlight! link javascriptGlobalArrayDot Grey
highlight! link javascriptGlobalBigIntDot Grey
highlight! link javascriptGlobalDateDot Grey
highlight! link javascriptGlobalJSONDot Grey
highlight! link javascriptGlobalMathDot Grey
highlight! link javascriptGlobalNumberDot Grey
highlight! link javascriptGlobalObjectDot Grey
highlight! link javascriptGlobalPromiseDot Grey
highlight! link javascriptGlobalRegExpDot Grey
highlight! link javascriptGlobalStringDot Grey
highlight! link javascriptGlobalSymbolDot Grey
highlight! link javascriptGlobalURLDot Grey
highlight! link javascriptMethod Green
highlight! link javascriptMethodName Green
highlight! link javascriptObjectMethodName Green
highlight! link javascriptGlobalMethod Green
highlight! link javascriptDOMStorageMethod Green
highlight! link javascriptFileMethod Green
highlight! link javascriptFileReaderMethod Green
highlight! link javascriptFileListMethod Green
highlight! link javascriptBlobMethod Green
highlight! link javascriptURLStaticMethod Green
highlight! link javascriptNumberStaticMethod Green
highlight! link javascriptNumberMethod Green
highlight! link javascriptDOMNodeMethod Green
highlight! link javascriptES6BigIntStaticMethod Green
highlight! link javascriptBOMWindowMethod Green
highlight! link javascriptHeadersMethod Green
highlight! link javascriptRequestMethod Green
highlight! link javascriptResponseMethod Green
highlight! link javascriptES6SetMethod Green
highlight! link javascriptReflectMethod Green
highlight! link javascriptPaymentMethod Green
highlight! link javascriptPaymentResponseMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptGeolocationMethod Green
highlight! link javascriptES6MapMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptCacheMethod Green
highlight! link javascriptFunctionMethod Green
highlight! link javascriptXHRMethod Green
highlight! link javascriptBOMNavigatorMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptDOMEventTargetMethod Green
highlight! link javascriptDOMEventMethod Green
highlight! link javascriptIntlMethod Green
highlight! link javascriptDOMDocMethod Green
highlight! link javascriptStringStaticMethod Green
highlight! link javascriptStringMethod Green
highlight! link javascriptSymbolStaticMethod Green
highlight! link javascriptRegExpMethod Green
highlight! link javascriptObjectStaticMethod Green
highlight! link javascriptObjectMethod Green
highlight! link javascriptBOMLocationMethod Green
highlight! link javascriptJSONStaticMethod Green
highlight! link javascriptGeneratorMethod Green
highlight! link javascriptEncodingMethod Green
highlight! link javascriptPromiseStaticMethod Green
highlight! link javascriptPromiseMethod Green
highlight! link javascriptBOMHistoryMethod Green
highlight! link javascriptDOMFormMethod Green
highlight! link javascriptClipboardMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptBroadcastMethod Green
highlight! link javascriptDateStaticMethod Green
highlight! link javascriptDateMethod Green
highlight! link javascriptConsoleMethod Green
highlight! link javascriptArrayStaticMethod Green
highlight! link javascriptArrayMethod Green
highlight! link javascriptMathStaticMethod Green
highlight! link javascriptSubtleCryptoMethod Green
highlight! link javascriptCryptoMethod Green
highlight! link javascriptProp Aqua
highlight! link javascriptBOMWindowProp Aqua
highlight! link javascriptDOMStorageProp Aqua
highlight! link javascriptFileReaderProp Aqua
highlight! link javascriptURLUtilsProp Aqua
highlight! link javascriptNumberStaticProp Aqua
highlight! link javascriptDOMNodeProp Aqua
highlight! link javascriptRequestProp Aqua
highlight! link javascriptResponseProp Aqua
highlight! link javascriptES6SetProp Aqua
highlight! link javascriptPaymentProp Aqua
highlight! link javascriptPaymentResponseProp Aqua
highlight! link javascriptPaymentAddressProp Aqua
highlight! link javascriptPaymentShippingOptionProp Aqua
highlight! link javascriptTypedArrayStaticProp Aqua
highlight! link javascriptServiceWorkerProp Aqua
highlight! link javascriptES6MapProp Aqua
highlight! link javascriptRegExpStaticProp Aqua
highlight! link javascriptRegExpProp Aqua
highlight! link javascriptXHRProp Aqua
highlight! link javascriptBOMNavigatorProp Green
highlight! link javascriptDOMEventProp Aqua
highlight! link javascriptBOMNetworkProp Aqua
highlight! link javascriptDOMDocProp Aqua
highlight! link javascriptSymbolStaticProp Aqua
highlight! link javascriptSymbolProp Aqua
highlight! link javascriptBOMLocationProp Aqua
highlight! link javascriptEncodingProp Aqua
highlight! link javascriptCryptoProp Aqua
highlight! link javascriptBOMHistoryProp Aqua
highlight! link javascriptDOMFormProp Aqua
highlight! link javascriptDataViewProp Aqua
highlight! link javascriptBroadcastProp Aqua
highlight! link javascriptMathStaticProp Aqua
" }}}
" vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty {{{
highlight! link jsxTagName OrangeItalic
highlight! link jsxOpenPunct Green
highlight! link jsxClosePunct Blue
highlight! link jsxEscapeJs Blue
highlight! link jsxAttrib Aqua
" }}}
" ft_end
