" -----------------------------------------------------------
" Fz84's ultimate vimrc, good for C/C++ developer
"                           ,---.-,                
"                          '   ,'  '.         ,--, 
"     ,---,.              /   /      \      ,--.'| 
"   ,'  .' |             .   ;  ,/.  :   ,--,  | : 
" ,---.'   |       ,----,'   |  | :  ;,---.'|  : ' 
" |   |   .'     .'   .`|'   |  ./   :;   : |  | ; 
" :   :  :    .'   .'  .'|   :       ,|   | : _' | 
" :   |  |-,,---, '   ./  \   \     / :   : |.'  | 
" |   :  ;/|;   | .'  /    ;   ,   '\ |   ' '  ; : 
" |   |   .'`---' /  ;--, /   /      \\   \  .'. | 
" '   :  '    /  /  / .`|.   ;  ,/.  : `---`:  | ' 
" |   |  |  ./__;     .' '   |  | :  ;      '  ; | 
" |   :  \  ;   |  .'    '   |  ./   :      |  : ; 
" |   | ,'  `---'        |   :      /       '  ,/  
" `----'                  \   \   .'        '--'   
"                          `---`-'                 
" -----------------------------------------------------------

" Settings for NERDTreeToggle
nmap <F2> :NERDTreeToggle<cr>

" Settings for Tarbar
nmap <F8> :TagbarToggle<CR>

" Settings for CCTree
let g:CCTreeKeyTraceForwardTree = '<C-\>>' 
let g:CCTreeKeyTraceReverseTree = '<C-\><' 
let g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting
let g:CCTreeKeySaveWindow = '<C-\>y' 
let g:CCTreeKeyToggleWindow = '<C-\>w' 
let g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree 
let g:CCTreeKeyDepthPlus = '<C-\>=' 
let g:CCTreeKeyDepthMinus = '<C-\>-'
