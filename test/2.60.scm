; for =zero?
(include "src/2.59.scm")

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
    (assert (equal? (sub p q) q))
    (assert (equal? (sub p z) p))
    (assert (=zero? (sub p p)))
    "All tests passed!"
  )
)

