(define z (make-complex (make-polar 5 0)))
(define w (make-complex (make-rectangular 2 3)))
(define p (make-rational (make-rat 2 3)))
(define q (make-rational (make-rat 1 4)))

(define (run)
  (let ()
    (assert (equ? 2 2))
    (assert (not (equ? 2 3)))
    (assert (equ? z z))
    (assert (not (equ? z w)))
    (assert (equ? p p))
    (assert (not (equ? p q)))
    "All tests passed!"
  )
)

