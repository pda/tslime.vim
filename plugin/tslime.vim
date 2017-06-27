" Tslime.vim. Send portion of buffer to tmux instance
" Maintainer: C.Coutinho <kikijump [at] gmail [dot] com>
" Licence:    DWTFYWTPL
"
" This is @pda's hack-and-slash based on the above.
" It removes default key bindings, and lots of other things.

if exists("g:tslime_loaded")
  finish
endif
let g:tslime_loaded = 1

function! Send_to_Tmux(text)
  call system("tmux set-buffer  '" . substitute(a:text, "'", "'\\\\''", 'g') . "'" )
  call system("tmux paste-buffer -t " . s:tmux_pane_number())
endfunction

function! s:tmux_pane_number()
  if !exists("g:tmux_pane_number")
    let g:tmux_pane_number = input("pane number: ", "")
  end
  return g:tmux_pane_number
endfunction
