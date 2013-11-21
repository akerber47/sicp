; We can retrieve a and b from 2^a*3^b because prime factorizations are unique.
; To do so, we simply divide out by 2 (or 3) until remainder is nonzero.

(define (cons a b) (* (exp 2 a) (exp 3 b)))

(define (car z) (if (= (remainder z 2) 0)
                    (+ 1 (car (/ z 2)))
                    0))
(define (cdr z) (if (= (remainder z 3) 0)
                    (+ 1 (cdr (/ z 3)))
                    0))
