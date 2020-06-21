(include "lib/2.number.scm")
(include "src/2.52.scm")
(include "src/2.53.scm")

(define (=zero?-number x)
  (equ? x 0))

(define (=zero?-complex z)
  (equ? (make-complex z)
        (make-complex (make-rectangular 0 0))))

(define (=zero?-rational q)
  (equ? (make-rational q)
        (make-rational (make-rat 0 1))))

(put 'number '=zero? =zero?-number)
(put 'complex '=zero? =zero?-complex)
(put 'rational '=zero? =zero?-rational)

(define (=zero? x) (operate '=zero? x))
