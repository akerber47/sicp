(define p
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 3)
      (adjoin-term
        (make-term 2 5)
        (adjoin-term
          (make-term 0 6)
          (the-empty-termlist))))))

(define q
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
    (assert (=zero? q))
    (assert (not (=zero? p)))
    "All tests passed!"
  )
)

