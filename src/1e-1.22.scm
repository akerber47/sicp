(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (jacobi a m)
  (define (jacobi-parity a m)
    (cond ((= a 1) 0)
          ((even? a)
           (+ (/ (- (square m) 1) 8)
              (jacobi-parity (/ a 2) m)))
          (else
           (+ (/ (* (- a 1) (- m 1)) 4)
              (jacobi-parity (remainder m a) a)))))
  (if (even? (jacobi-parity a m))
      1
      -1))

(define (solovay-strassen-test n)
  (define (try-it a)
    (or (not (= (gcd n a) 1))
        (and (= (jacobi a n) 1)  (= (expmod a (/ (- n 1) 2) n) 1))
        (and (= (jacobi a n) -1) (= (expmod a (/ (- n 1) 2) n) (- n 1)))))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((solovay-strassen-test n) (fast-prime? n (- times 1)))
        (else false)))
; > (fast-prime? 561 50)
; #f
; > (fast-prime? 1009 50)
; #t
; > (fast-prime? 1005 50)
; #f
; > (fast-prime? 1729 50)
; #f
; etc etc.
