let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
      \ 'javascript':     ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'typescript':     ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'html': ['/usr/local/bin/html-languageserver', '--stdio'],
      \ 'css':  ['/usr/local/bin/css-languageserver', '--stdio'],
      \ 'sass': ['/usr/local/bin/css-languageserver', '--stdio'],
      \ 'scss': ['/usr/local/bin/css-languageserver', '--stdio'],
      \ }
let g:LanguageClient_signColumnAlwaysOn = 1
let g:LanguageClient_diagnosticsDisplay = {
      \ 1: { "name": "Error",
      \      "signText": "●",
      \      "signTexthl": "ALEErrorSign"
      \    },
      \ 2: { "name": "Warning",
      \      "signText": "●",
      \      "signTexthl": "ALEWarningSign"
      \    },
      \ 3: { "name": "Information",
      \      "signText": "",
      \      "signTexthl": "SignInformation",
      \      "texthl": "LanguageClientInformation"
      \    },
      \ 4: { "name": "Hint",
      \      "signText": "",
      \      "signTexthl": "SignHint",
      \      "texthl": "LanguageClientHint"
      \    }
      \ }

