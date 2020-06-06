; Point constructor and selectors
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

; Segment constructor and selectors
(define (make-segment p q) (cons p q))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (make-point (/ (+ (x-point (start-segment s))
                    (x-point (end-segment s)))
                 2)
              (/ (+ (y-point (start-segment s))
                    (y-point (end-segment s)))
                 2)))

