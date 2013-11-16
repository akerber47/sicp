(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

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

; Output:
; > (search-for-primes 1000 1050)
; 1001
; 1003
; 1005
; 1007
; 1009 *** 2
; 1011
; 1013 *** 2
; 1015
; 1017
; 1019 *** 2
; 1021 *** 2
; 1023
; 1025
; 1027
; 1029
; 1031 *** 2
; 1033 *** 1
; 1035
; 1037
; 1039 *** 1
; 1041
; 1043
; 1045
; 1047
; 1049 *** 2
; > (search-for-primes 10000 10050)
;
; 10001
; 10003
; 10005
; 10007 *** 5
; 10009 *** 4
; 10011
; 10013
; 10015
; 10017
; 10019
; 10021
; 10023
; 10025
; 10027
; 10029
; 10031
; 10033
; 10035
; 10037 *** 4
; 10039 *** 4
; 10041
; 10043
; 10045
; 10047
; 10049
; > (search-for-primes 100000 100050)
;
; 100001
; 100003 *** 16
; 100005
; 100007
; 100009
; 100011
; 100013
; 100015
; 100017
; 100019 *** 16
; 100021
; 100023
; 100025
; 100027
; 100029
; 100031
; 100033
; 100035
; 100037
; 100039
; 100041
; 100043 *** 13
; 100045
; 100047
; 100049 *** 13
; > (search-for-primes 1000000 1000050)
;
; 1000001
; 1000003 *** 59
; 1000005
; 1000007
; 1000009
; 1000011
; 1000013
; 1000015
; 1000017
; 1000019
; 1000021
; 1000023
; 1000025
; 1000027
; 1000029
; 1000031
; 1000033 *** 39
; 1000035
; 1000037 *** 39
; 1000039 *** 39
; 1000041
; 1000043
; 1000045
; 1000047
; 1000049
;
; It's roughly proportional, yes. We roughly have
; time 1.5 near 1000
;      4.0 near 10000
;      15  near 100000
;      40  near 1000000
; so ratios are about 2.25 (ish...)
