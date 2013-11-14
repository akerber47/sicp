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

(define (cc amount)
  (if (< amount 0)
      0
      (cc-iter 1 0 0 0 0 0 0 0 0 0
      	       1 0 0 0 0 0 0 0 0 0
      	       1 0 0 0 0 0 0 0 0 0
      	       1 0 0 0 0 0 0 0 0 0
      	       amount)))

(define (cc-iter  a  b  c  d  e  f  g  h  i  j
		 qa qb qc qd qe qf qg qh qi qj
		 da db dc dd de df dg dh di dj
		 na nb nc nd ne nf ng nh ni nj
		 count)
  (if (< count 5)
      a
      (cc-iter (+ 1 na db qe j) a  b  c  d  e  f  g  h  i
      	       (+ 1 na db qe)  qa qb qc qd qe qf qg qh qi
      	       (+ 1 na db)     da db dc dd de df dg dh di
      	       (+ 1 na)        na nb nc nd ne nf ng nh ni
      	       (- count 5))))

; Of course, now we can look at this and realize we don't need most of these
; variables, making this ever so slightly neater.
(define (cc-iter-new  a  b  c  d  e  f  g  h  i  j
		     qa qb qc qd qe
		     da db
		     na
		     count)
  (if (< count 5)
      a
      (cc-iter (+ 1 na db qe j) a  b  c  d  e  f  g  h  i
      	       (+ 1 na db qe)  qa qb qc qd
      	       (+ 1 na db)     da
      	       (+ 1 na)
      	       (- count 5))))

; Neither of these generalizes well at all. Is there a nice way to write
; something that does?
