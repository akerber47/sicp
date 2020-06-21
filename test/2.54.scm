(define z (make-complex (make-polar 5 0)))
(define w (make-complex (make-rectangular 2 3)))
(define p (make-rational (make-rat 2 3)))
(define q (make-rational (make-rat 1 4)))

(define (run)
  (let ()
    (assert (=zero? 0))
    (assert (not (=zero? 2)))
    (assert (=zero? (make-complex (make-rectangular 0 0))))
    (assert (not (=zero? z)))
    (assert (=zero? (make-rational (make-rat 0 1))))
    (assert (not (=zero? p)))
    "All tests passed!"
  )
)

