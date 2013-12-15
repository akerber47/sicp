#lang s-exp syntax/module-reader
  "sicp.rkt"

; Simple reader to read SICP like R5RS.

#:wrapper1 (lambda (proc)
             (parameterize ([read-accept-infix-dot        #f]
                            [read-case-sensitive          #f]
                            [read-curly-brace-as-paren    #f]
                            [read-square-bracket-as-paren #f])
               (proc)))

