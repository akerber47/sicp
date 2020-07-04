(define (make-cycle x)
  (define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
  (set-cdr! (last-pair x) x)
  x)

(define x '(a b c))
(define y '((a b c) d e (f g) h (i j) k))
(define z (make-cycle '(a b c)))
(define w (make-cycle '((a b c) d e (f g) h (i j) k)))
(set-car! (cddr w) w)

(define (run)
  (let ()
    (assert (equal? (count-pairs z) 3))
    (assert (equal? (count-pairs x) 3))
    (assert (equal? (count-pairs y) (count-pairs w)))
    (assert (equal? (find-cycle x) #f))
    (assert (equal? (find-cycle y) #f))
    (assert (equal? (find-cycle z) #t))
    (assert (equal? (find-cycle w) #t))
    (assert (equal? (find-cycle-o1 x) #f))
    (assert (equal? (find-cycle-o1 y) #f))
    (assert (equal? (find-cycle-o1 z) #t))
    (assert (equal? (find-cycle-o1 w) #t))
    "All tests passed!"))
