(define (eps-eq? a b)
  (and (< (- a b) 0.0001)
       (< (- b a) 0.0001)))

(define (run)
  (assert (eps-eq? (cbrt 8.0) 2.0))
  (assert (eps-eq? (cbrt 1.0) 1.0))
  (assert (eps-eq? (cbrt 1000.0) 10.0))
  (assert (eps-eq? (cbrt 1000000.0) 100.0))
  "All tests passed!"
)
