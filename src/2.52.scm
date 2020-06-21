(include "lib/2.number.scm")

(define (make-rational q)
  (attach-type 'rational q))

(define (+rational q r)
  (make-rational (+rat q r)))

(define (-rational q r)
  (make-rational (-rat q r)))

(define (*rational q r)
  (make-rational (*rat q r)))

(define (/rational q r)
  (make-rational (/rat q r)))

(put 'rational 'add +rational)
(put 'rational 'sub -rational)
(put 'rational 'mul *rational)
(put 'rational 'div /rational)
