(define (same-parity x . z)
  (define (parity-filter z)
    (if (null? z)
        nil
        (if (even? (+ x (car z)))
            (cons (car z) (parity-filter (cdr z)))
            (parity-filter (cdr z)))))
  (cons x (parity-filter z)))
