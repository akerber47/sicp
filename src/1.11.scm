; Recursive
(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

; Iterative
; Similarly to the fibonacci example, after n iterations, want a, b, and c
; to equal f(n+2), f(n+1), and f(n).
(define (f-iter n)
  (f-iter-help 2 1 0 n))

(define (f-iter-help a b c count)
  (if (= count 0)
      c
      (f-iter-help (+ a (* 2 b) (* 3 c)) a b (- count 1))))
