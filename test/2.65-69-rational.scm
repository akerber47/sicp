; 2.65
(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))

; 2.66
(define q1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define q2 (make-polynomial 'x '((3 1) (1 -1))))

; 2.67
(define a1 (make-polynomial 'x '((2 1) (1 -2) (0 1))))
(define a2 (make-polynomial 'x '((2 11) (0 7))))
(define a3 (make-polynomial 'x '((1 13) (0 5))))
(define b1 (mul a1 a2))
(define b2 (mul a1 a3))

; 2.69
(define x1 (make-polynomial 'x '((1 1) (0 1))))
(define x2 (make-polynomial 'x '((3 1) (0 -1))))
(define x3 (make-polynomial 'x '((1 1))))
(define x4 (make-polynomial 'x '((2 1) (0 -1))))
(define a '((1 1) (0 1)))
(define b '((3 1) (0 -1)))
(define pgcd (pseudo-gcd-terms b a))
(define factor '(0 -8))
(define rf1 (make-rational x1 x2))
(define rf2 (make-rational x3 x4))

(define (run)
  (let ()
    ; 2.65
    (write-line rf)
    (write-line (add rf rf))
    ; 2.66
    (write-line (greatest-common-divisor q1 q2))
    ; 2.67
    (write-line (greatest-common-divisor b1 b2))
    ; 2.69
    (write-line (pseudo-remainder-terms a b))
    (write-line (pseudo-remainder-terms b a))
    (write-line (pseudo-gcd-terms a b))
    (write-line (pseudo-gcd-terms b a))
    (write-line (reduce a b))
    (write-line (reduce b a))
    (write-line "Final addition test:")
    (write-line (add rf1 rf2))
    "All tests passed!"))

