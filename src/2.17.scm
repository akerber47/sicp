(define (reverse items)
  (define (reverse-iter a b)
    (if (null? a)
        b
        (reverse-iter (cdr a) (cons (car a) b))))
  (reverse-iter items nil))
