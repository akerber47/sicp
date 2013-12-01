(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n 50)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes a b)
  (define (test-and-continue a b)
    (timed-prime-test a)
    (search-for-primes (+ a 2) b))
  (if (even? a)
      (search-for-primes (+ a 1) b)
      (if (> a b)
          (newline)
          (test-and-continue a b))))

; Old output from 1.22.scm (pruned):
; > (search-for-primes 1000 1050)
; 1009 *** 2
; 1013 *** 2
; 1019 *** 2
; > (search-for-primes 10000 10050)
; 10007 *** 5
; 10009 *** 4
; 10037 *** 4
; > (search-for-primes 100000 100050)
; 100003 *** 16
; 100019 *** 16
; 100043 *** 13
; > (search-for-primes 1000000 1000050)
; 1000003 *** 59
; 1000033 *** 39
; 1000037 *** 39
;
; New output (pruned) - running 50 trials on each prime:
; > (search-for-primes 1000 1050)
; 1009 *** 48
; 1013 *** 50
; 1019 *** 51
; > (search-for-primes 10000 10050)
; 10007 *** 62
; 10009 *** 59
; 10037 *** 60
; > (search-for-primes 100000 100050)
; 100003 *** 89
; 100019 *** 70
; 100043 *** 71
; > (search-for-primes 1000000 1000050)
; 1000003 *** 137
; 1000033 *** 80
; 1000037 *** 83
;
; As expected for O(log n), fast-prime takes approximately twice as long to run
; near 10^6 = (10^3)^2 as it does near 10^3.
