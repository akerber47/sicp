(define (square x) (* x x))

(define (new-smallest-divisor n)
  (new-find-divisor n 2))
(define (new-find-divisor n test-divisor)
  (define (next d)
    (if (= d 2) 3 (+ d 2)))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (new-find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (new-smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
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
; New output (pruned):
; > (search-for-primes 1000 1050)
; 1009 *** 1
; 1013 *** 1
; 1019 *** 1
; > (search-for-primes 10000 10050)
; 10007 *** 3
; 10009 *** 2
; 10037 *** 2
; > (search-for-primes 100000 100050)
; 100003 *** 11
; 100019 *** 7
; 100043 *** 7
; > (search-for-primes 1000000 1000050)
; 1000003 *** 29
; 1000033 *** 20
; 1000037 *** 20
;
; It's approximately twice as fast for most of the primes under
; consideration, yes.
