" Derived from the dark.vim theme shipped with vim-airline

source $HOME/.cache/wal/colors-wal.vim

scriptencoding utf-8

let g:airline#themes#wal#palette = {}

let s:airline_a_normal   = [ background , color5    , 17  , 190 ]
let s:airline_b_normal   = [ foreground , color2    , 255 , 238 ]
let s:airline_c_normal   = [ foreground , '#202020' , 85  , 234 ]
let g:airline#themes#wal#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

let g:airline#themes#wal#palette.normal_modified = {
      \ 'airline_c': [ foreground , color1 , 255 , 53 , '' ] ,
      \ }


let s:airline_a_insert = [ background , color6    , 17  , 45  ]
let s:airline_b_insert = [ foreground , color3    , 255 , 27  ]
let s:airline_c_insert = [ foreground , '#202020' , 15  , 17  ]
let g:airline#themes#wal#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#wal#palette.insert_modified = {
      \ 'airline_c': [ foreground , color1 , 255 , 53 , '' ] ,
      \ }
let g:airline#themes#wal#palette.insert_paste = {
      \ 'airline_a': [ s:airline_a_insert[0]   , '#d78700' , s:airline_a_insert[2] , 172     , ''     ] ,
      \ }


let g:airline#themes#wal#palette.replace = copy(g:airline#themes#wal#palette.insert)
let g:airline#themes#wal#palette.replace.airline_a = [ s:airline_b_insert[0]   , '#af0000' , s:airline_b_insert[2] , 124     , ''     ]
let g:airline#themes#wal#palette.replace_modified = g:airline#themes#wal#palette.insert_modified


let s:airline_a_visual = [ background , color1    , 232 , 214 ]
let s:airline_b_visual = [ background , color4    , 232 , 202 ]
let s:airline_c_visual = [ foreground , '#202020' , 15  , 52  ]
let g:airline#themes#wal#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
let g:airline#themes#wal#palette.visual_modified = {
      \ 'airline_c': [ foreground , color1 , 255 , 53 , '' ] ,
      \ }


let s:airline_a_inactive = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:airline_b_inactive = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:airline_c_inactive = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#wal#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#wal#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }

let s:airline_a_commandline = [ '#0000ff' , '#0cff00' , 17  , 40 ]
let s:airline_b_commandline = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:airline_c_commandline = [ '#9cffd3' , '#202020' , 85  , 234 ]
let g:airline#themes#wal#palette.commandline = airline#themes#generate_color_map(s:airline_a_commandline, s:airline_b_commandline, s:airline_c_commandline)

let g:airline#themes#wal#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , ''  ]
      \ }


if get(g:, 'loaded_ctrlp', 0)
  let g:airline#themes#wal#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
        \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
        \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])
endif
