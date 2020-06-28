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

(define (run)
  (let ()
    ; 2.65
    (write-line rf)
    (write-line (add rf rf))
    ; 2.66
    (write-line (greatest-common-divisor q1 q2))
    ; 2.67
    (write-line (greatest-common-divisor b1 b2))
    "All tests passed!"))

