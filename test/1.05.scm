(define (eps-eq? a b)
  (and (< (- a b) 0.0001)
       (< (- b a) 0.0001)))

(define (run)
  (assert (eps-eq? (new-sqrt 4.0) 2.0))
  (assert (eps-eq? (new-sqrt 1.0) 1.0))
  (assert (eps-eq? (new-sqrt 100.0) 10.0))
  (assert (eps-eq? (new-sqrt 10000.0) 100.0))
  "All tests passed!"
)
