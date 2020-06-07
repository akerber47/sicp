; NEW SOLUTION
; ---------------------------------------------------
; Use multi loop iteration (equivalent to nested for
; loops) using an additional variable to track which
; loop we're currently in).
; ---------------------------------------------------
; time complexity: O(a^n)
; space complexity: O(n)
; ---------------------------------------------------
(define (cc-loop amount)
  (if
    (= amount 0)
    1
    (cc-loop-iter amount 0 0 0 0 0 0 1)))

(define (cc-loop-iter a i1 i2 i3 i4 i5 acc iter)
  (define tot
    (+ (* i1 1)
       (* i2 5)
       (* i3 10)
       (* i4 25)
       (* i5 50)))
  (define new-tot
    (+ tot
       (cond
         ((= iter 1) 1)
         ((= iter 2) 5)
         ((= iter 3) 10)
         ((= iter 4) 25)
         ((= iter 5) 50))))
  (define new-acc
    (if (= new-tot a)
        (+ acc 1)
        acc))
  (cond
    ((< tot a)
     (cc-loop-iter
       a
       (if (= iter 1)
           (+ i1 1)
           i1)
       (if (= iter 2)
           (+ i2 1)
           i2)
       (if (= iter 3)
           (+ i3 1)
           i3)
       (if (= iter 4)
           (+ i4 1)
           i4)
       (if (= iter 5)
           (+ i5 1)
           i5)
       new-acc
       1))
    ((= iter 1)
     (cc-loop-iter a 0 i2 i3 i4 i5 acc 2))
    ((= iter 2)
     (cc-loop-iter a 0 0 i3 i4 i5 acc 3))
    ((= iter 3)
     (cc-loop-iter a 0 0 0 i4 i5 acc 4))
    ((= iter 4)
     (cc-loop-iter a 0 0 0 0 i5 acc 5))
    ((= iter 5)
      acc)))


; OLD SOLUTION FROM 2013
; ---------------------------------------------------
; Use dynamic programming-style tracking of all previous
; values that could possibly be needed. This would normally be
; a huge number (1+5+10+25+50 values), so we need to use a trick
; to track only the values on cases divisible by 5
; ---------------------------------------------------
; time complexity: O(a*n)
; space complexity: O(a*n)
;
; Notice that if n is divisible by 5, then n,n+1,n+2,n+3,n+4
; all have same # of ways to change amount. Therefore we really only
; need to compute information about amounts which are multiples of 5.
;
; Key idea is that CC(n) = CC(n-50)+CC_q(n-25)+CC_d(n-10)+CC_n(n-5)+1
; where CC_<denom> is restricted to only using coins <denom> or smaller.
; (The extra 1 is, effectively, CC_p(n-1), but CC_p is constantly 1)
;
; Similarly
; CC_q(n) = CC_q(n-25)+CC_d(n-10)+CC_n(n-5)+1
; CC_d(n) = CC_d(n-10)+CC_n(n-5)+1
; CC_n(n) = CC_n(n-5)+1
; for all n >= 0.
;
; There's no kill like overkill. After n iterations,
; <denom>a = CC_<denom>(5n)
; <denom>b = CC_<denom>(5n-5)
; ...
; <denom>j = CC_<denom>(5n-45)

(define (cc-dyn amount)
  (if (< amount 0)
      0
      (cc-dyn-iter 1 0 0 0 0 0 0 0 0 0
                   1 0 0 0 0 0 0 0 0 0
                   1 0 0 0 0 0 0 0 0 0
                   1 0 0 0 0 0 0 0 0 0
                   amount)))

(define (cc-dyn-iter  a  b  c  d  e  f  g  h  i  j
                     qa qb qc qd qe qf qg qh qi qj
                     da db dc dd de df dg dh di dj
                     na nb nc nd ne nf ng nh ni nj
                     count)
  (if (< count 5)
      a
      (cc-dyn-iter (+ 1 na db qe j) a  b  c  d  e  f  g  h  i
                   (+ 1 na db qe)  qa qb qc qd qe qf qg qh qi
                   (+ 1 na db)     da db dc dd de df dg dh di
                   (+ 1 na)        na nb nc nd ne nf ng nh ni
                   (- count 5))))

; Of course, now we can look at this and realize we don't need most of these
; variables, making this ever so slightly neater.
(define (cc-dyn-opt amount)
  (if (< amount 0)
      0
      (cc-dyn-opt-iter 1 0 0 0 0 0 0 0 0 0
                       1 0 0 0 0
                       1 0
                       1
                       amount)))
(define (cc-dyn-opt-iter a  b  c  d  e  f  g  h  i  j
                        qa qb qc qd qe
                        da db
                        na
                        count)
  (if (< count 5)
      a
      (cc-dyn-opt-iter (+ 1 na db qe j) a  b  c  d  e  f  g  h  i
                       (+ 1 na db qe)  qa qb qc qd
                       (+ 1 na db)     da
                       (+ 1 na)
                       (- count 5))))

; Neither of these generalizes well at all. Is there a nice way to write
; something that does?
