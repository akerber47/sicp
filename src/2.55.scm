(include "lib/2.number.scm")
(include "src/2.52.scm")

; Note: we never actually defined an integer type.
; So this part will be untested
(define (raise-integer n)
  (make-rational (make-rat n 1)))

(define (raise-rational q)
  (/ (numer q) (denom q)))

(define (raise-number x)
  (make-complex (make-rectangular x 0)))

(put 'number 'raise raise-number)
(put 'rational 'raise raise-rational)
(put 'integer 'raise raise-integer)

(define (raise x) (operate 'raise x))
