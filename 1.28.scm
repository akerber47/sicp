(define (square x) (* x x))

(define (expmod-signal base exp m)
  (define (check-and-squaremod a m)
    (if (and (= (remainder (square a) m) 1)
             (not (= (remainder a m) 1))
             (not (= (remainder a m) (- m 1))))
        0
        (remainder (square a) m)))
  (cond ((= exp 0) 1)
        ((even? exp)
         (check-and-squaremod (expmod-signal base (/ exp 2) m)
                              m))
        (else
         (remainder (* base (expmod-signal base (- exp 1) m))
                            m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod-signal a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

; 561, 1105, 1729, 2465, 2821, and 6601
; > (fast-prime? 561 50)
; #f
; > (fast-prime? 1105 50)
; #f
; > (fast-prime? 1729 50)
; #f
; > (fast-prime? 2465 50)
; #f
; > (fast-prime? 2821 50)
; #f
; > (fast-prime? 6601 50)
; #f
;
; Some random others
;
; > (fast-prime? 1009 50)
; #t
; > (fast-prime? 5 50)
; #t
; > (fast-prime? 1000039 50)
; #t
; > (fast-prime? 1000031 50)
