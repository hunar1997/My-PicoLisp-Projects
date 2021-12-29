# Practically complete :)

* Put this file in (make folders if there isn't any)  
 `~/.vim/syntax/l.vim`

* To use it manually, open a file and  
 `:set syntax=l`       to activate it


* To detect it automatically, make this file  
 `~/.vim/ftdetect/l.vim`  
 And write this inside it  
 `autocmd BufRead,BufNewFile *.l set filetype=l`

### Issues:
It highlits strings,comments, and all the symbols in (all) except  `|` `\` `.` `^`   because I couldn't figure out how, I don't know vimscript

Enjoy :D