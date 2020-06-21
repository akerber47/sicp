(define z (make-complex (make-rectangular 5 0)))
(define p (make-rational (make-rat 5 1)))

(define (run)
  (let ()
    (assert (equ? (add p 3) 8))
    (assert (equ? (add z 3) (make-complex (make-rectangular 8 0))))
    (assert (equ? (add z p) (make-complex (make-rectangular 10 0))))
    "All tests passed!"
  )
)

