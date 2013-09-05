" Tslime.vim. Send portion of buffer to tmux instance
" Maintainer: C.Coutinho <kikijump [at] gmail [dot] com>
" Licence:    DWTFYWTPL
"
" This is Paul Annesley's hack-and-slash based on the above.
" It removes default key bindings, and lots of other things.
" It adds tmux_buffer_from_file and Send_ctrlc_to_Tmux.
" The latter depends on a hacky external file containing a single 0x03 byte.
" I'm sure there's a better way.

if exists("g:tslime_loaded")
  finish
endif

let g:tslime_loaded = 1

" Main function.
" Use it in your script if you want to send text to a tmux session.
function! Send_to_Tmux(text)
  call s:tmux_buffer_from_text(a:text)
  call s:tmux_from_buffer()
endfunction

function! Send_ctrlc_to_Tmux()
  call s:tmux_buffer_from_file("~/.ctrlc")
  call s:tmux_from_buffer()
endfunction

function! s:tmux_buffer_from_file(path)
  call system("tmux load-buffer " . a:path)
endfunction

function! s:tmux_buffer_from_text(text)
  call system("tmux set-buffer  '" . substitute(a:text, "'", "'\\\\''", 'g') . "'" )
endfunction

function! s:tmux_from_buffer()
  call system("tmux paste-buffer -t " . s:tmux_pane_number())
endfunction

function! s:tmux_pane_number()
  if !exists("g:tmux_pane_number")
    let g:tmux_pane_number = input("pane number: ", "")
  end
  return g:tmux_pane_number
endfunction
