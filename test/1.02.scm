(define (run)
  (assert (= (ss2l 0 0 0) 0))
  (assert (= (ss2l 1 1 0) 2))
  (assert (= (ss2l 1 0 1) 2))
  (assert (= (ss2l 0 1 1) 2))
  (assert (= (ss2l 1 1 1) 2))
  (assert (= (ss2l 3 4 5) 41))
  "All tests passed!"
)
