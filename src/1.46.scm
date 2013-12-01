(define (iterative-improve good-enough? improve)
  ; Need to return a recursive procedure
  (define (proc-to-return guess)
    (if (good-enough? guess)
        guess
        (proc-to-return (improve guess))))
  proc-to-return)

; sqrt checks if guesses are good enough by comparing their squares against x,
; and improves guesses by averaging w x/guess.
(define (sqrt x)
  (iterative-improve (lambda (guess)
                       (< (abs (- (* guess guess) x)) 0.001))
                     (lambda (guess)
                       (/ (+ guess (/ x guess)) 2)))
  1.0)

; fixed-point checks if guesses are good enough by comparing successive
; guesses, and improves guesses by applying f.
(define (fixed-point f)
  (iterative-improve (lambda (guess)
                       (< (abs (- guess (f guess))) 0.00001))
                     f)
  1.0)
