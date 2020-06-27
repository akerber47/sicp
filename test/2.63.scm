(define p
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 4)
      (adjoin-term
        (make-term 2 10)
        (adjoin-term
          (make-term 0 6)
          (the-empty-termlist))))))


(define q
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 2)
      (adjoin-term
        (make-term 2 5)
        (adjoin-term
          (make-term 0 3)
          (the-empty-termlist))))))

(define r
  (make-polynomial
    'x
    (adjoin-term
      (make-term 1 2)
      (adjoin-term
        (make-term 0 5)
        (the-empty-termlist)))))

(define z
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 0)
      (adjoin-term
        (make-term 2 0)
        (adjoin-term
          (make-term 0 0)
          (the-empty-termlist))))))

(define (run)
  (let ()
    (assert (equal? (div p q) '((polynomial x (0 2))
                                (polynomial x))))
    (assert (equal? (div p r) '((polynomial x (2 2))
                                (polynomial x (0 6)))))
    (assert (equal? (div r p) (list '(polynomial x) r)))
    "All tests passed!"
  )
)

