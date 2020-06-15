(define (atom-equal? a b)
  (cond
    ((and (atom? a) (atom? b)) (eq? a b))
    ((or (atom? a) (atom? b)) #f)
    (else (and (atom-equal? (car a) (car b))
               (atom-equal? (cdr a) (cdr b))))))
