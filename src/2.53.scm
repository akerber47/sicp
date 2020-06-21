(include "lib/2.number.scm")
(include "src/2.52.scm")

(define (equ?-number x y)
  (= x y))

(define (equ?-complex z w)
  (and (= (real-part z) (real-part w))
       (= (imag-part z) (imag-part w))))

(define (equ?-rational q r)
  (=rat q r))

(put 'number 'equ? equ?-number)
(put 'complex 'equ? equ?-complex)
(put 'rational 'equ? equ?-rational)

(define (equ? x y) (operate-2 'equ? x y))
