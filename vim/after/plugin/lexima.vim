if !exists('g:loaded_lexima')
  finish
endif

" Don't close if add pair just before a word
call lexima#add_rule({'char': '(', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '[', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '{', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '"', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': "'", 'at': '\%#[0-9a-zA-Z]', 'leave': 0})

