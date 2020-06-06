(define (for-each proc items)
  (define (call-and-recur proc items)
    (proc (car items))
    (for-each proc (cdr items)))
  (if (null? items)
      #t
      (call-and-recur proc items))
