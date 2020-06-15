(define (run)
  (assert (atom-equal? 1 1))
  (assert (atom-equal? nil nil))
  (assert (atom-equal? (list 'a 2) (list 'a 2)))
  (assert (atom-equal? (list (list 'a 'b) (list (list 'c)) 'd)
                  (list (list 'a 'b) (list (list 'c)) 'd)))
  (assert (not (atom-equal? 1 nil)))
  (assert (not (atom-equal? 1 2)))
  (assert (not (atom-equal? (list 'a 2) 'a)))
  (assert (not (atom-equal?
                 (list (list 'a 'b) (list (list 'c)) 'd)
                 (list 'a 'b 'c 'd))))
  "All tests passed!"
)
