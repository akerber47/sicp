(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Renamed some variables for clarity
; (add-1 zero)
; => (add-1 (lambda (f0) (lambda (x0) x0)))
; => (lambda (f) (lambda (x) (f (((lambda (f0) (lambda (x0) x0)) f) x))))
; => (lambda (f) (lambda (x) (f ((lambda (x0) x0) x))))
; => (lambda (f) (lambda (x) (f x)))
(define one (lambda (f) (lambda (x) (f x))))

; (add-1 one)
; => (add-1 (lambda (f1) (lambda (x1) (f1 x1))))
; => (lambda (f) (lambda (x) (f (((lambda (f1) (lambda (x1) (f1 x1))) f) x))))
; => (lambda (f) (lambda (x) (f ((lambda (x1) (f x1)) x))))
; => (lambda (f) (lambda (x) (f (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; Basically numeral n is "take in a function (f) and a thingy (x), then
; return the result of applying f to x n times"
; So to add the number of applications, we need to give our 2 numerals the same
; f to apply repeatedly, and then apply these repeated applications one at a
; time to our x.
(define (add n1 n2)
  (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))
