(include "lib/2.huffman.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol s tree)
  (cond
    ((not (memq s (symbols tree)))
     (error "Symbol not found in tree!" s))
    ((leaf? tree)
     '())
    ((memq s (symbols (left-branch tree)))
     (cons 0 (encode-symbol s (left-branch tree))))
    (else
     (cons 1 (encode-symbol s (right-branch tree))))))
