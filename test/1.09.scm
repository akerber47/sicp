(define (run)
  (assert (= (cc-dyn 100) 292))
  (assert (= (cc-dyn-opt 100) 292))
  (assert (= (cc-loop 100) 292))
  (assert (= (cc-loop 0) 1))
  (assert (= (cc-loop 1) 1))
  (assert (= (cc-loop 10) 4))
  "All tests passed!"
)
