(define z (make-complex (make-rectangular 5 0)))
(define p (make-rational (make-rat 5 1)))
(include "src/2.53.scm")

(define (run)
  (let ()
    (assert (equ? (raise-integer 5) p))
    (assert (equ? (raise p) 5.0))
    (assert (equ? (raise 5.0) z))
    "All tests passed!"
  )
)

