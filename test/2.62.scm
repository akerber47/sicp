(define p
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 4)
      (adjoin-term
        (make-term 2 10)
        (adjoin-term
          (make-term 0 6)
          (the-empty-termlist-sparse))))))

(define pd
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 4)
      (adjoin-term
        (make-term 2 10)
        (adjoin-term
          (make-term 0 6)
          (the-empty-termlist-dense))))))

(define q
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 2)
      (adjoin-term
        (make-term 2 5)
        (adjoin-term
          (make-term 0 3)
          (the-empty-termlist-sparse))))))

(define qd
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 2)
      (adjoin-term
        (make-term 2 5)
        (adjoin-term
          (make-term 0 3)
          (the-empty-termlist-dense))))))

(define z
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 0)
      (adjoin-term
        (make-term 2 0)
        (adjoin-term
          (make-term 0 0)
          (the-empty-termlist-sparse))))))

(define zd
  (make-polynomial
    'x
    (adjoin-term
      (make-term 3 0)
      (adjoin-term
        (make-term 2 0)
        (adjoin-term
          (make-term 0 0)
          (the-empty-termlist-dense))))))

(define (run)
  (let ()
    ; sparse
    (assert (equal? (add q q) p))
    (assert (equal? (add q z) q))
    (assert (equal? (add z p) p))
    ; dense
    (assert (equal? (add qd qd) pd))
    (assert (equal? (add pd zd) pd))
    (assert (equal? (add zd qd) qd))
    ; mixed (note type from 2nd argument if equal size
    (assert (equal? (add qd q) p))
    (assert (equal? (add q qd) pd))
    (assert (equal? (add pd z) pd))
    "All tests passed!"
  )
)

