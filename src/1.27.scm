(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (exhaustive-fermat-test n)
  (define (test-iter a n)
    (cond ((= a n) true)
          ((= (expmod a n n) a) (test-iter (+ a 1) n))
          (else false)))
  (test-iter 1 n))

; 561, 1105, 1729, 2465, 2821, and 6601
; > (exhaustive-fermat-test 561)
; #t
; > (exhaustive-fermat-test 1105)
; #t
; > (exhaustive-fermat-test 1729)
; #t
; > (exhaustive-fermat-test 2465)
; #t
; > (exhaustive-fermat-test 2821)
; #t
; > (exhaustive-fermat-test 6601)
; #t
