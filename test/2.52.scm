(define z (make-complex (make-polar 5 0)))
(define w (make-complex (make-rectangular 2 3)))

(define (run)
  (let ((p (make-rational (make-rat 2 3)))
        (q (make-rational (make-rat 1 4))))
    (assert (equal? (add z w)
                    '(complex rectangular 7 . 3)))
    (assert (equal? (add p q)
                    '(rational 11 . 12)))
    (assert (equal? (mul p q)
                    '(rational 1 . 6)))
    (assert (equal? (sub q p)
                    '(rational -5 . 12)))
    "All tests passed!"
  )
)

