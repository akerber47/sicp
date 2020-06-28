(include "lib/2.algebra.scm")

; for (/terms)
(include "src/2.63.scm")

; Exercises about rational functions

; 2.65 rational function type

; redefine make-rat without lowest terms
(define (make-rat n d)
  (cons n d))

(define (make-rational n d)
  (attach-type 'rational (make-rat n d)))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (+rat x y)
  (make-rational (add (mul (numer x) (denom y))
                      (mul (denom x) (numer y)))
                 (mul (denom x) (denom y))))

(define (-rat x y)
  (make-rational (sub (mul (numer x) (denom y))
                      (mul (denom x) (numer y)))
                 (mul (denom x) (denom y))))

(define (*rat x y)
  (make-rational (mul (numer x) (numer y))
                 (mul (denom x) (denom y))))

(define (/rat x y)
  (make-rational (mul (numer x) (denom y))
                 (mul (denom x) (numer y))))

(put 'rational 'add +rat)
(put 'rational 'sub -rat)
(put 'rational 'mul *rat)
(put 'rational 'div /rat)

; 2.66 gcd-poly

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (remainder-terms a b)
  (cadr (/terms a b)))

(define (gcd-poly p q)
  (if (eq? (variable p) (variable q))
      (make-polynomial (variable p)
                       (gcd-terms (term-list p) (term-list q)))
      (error "Polynomials not in same variable!" (list p q))))

(define (greatest-common-divisor x y)
  (operate-2 'gcd x y))

(put 'number 'gcd gcd)
(put 'polynomial 'gcd gcd-poly)

; 2.67 pseudo-remainder and reduce

(define (pseudo-gcd-terms a b)
  (if (empty-termlist? b)
      a
      (pseudo-gcd-terms b (pseudo-remainder-terms a b))))

; from Ch 1
(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp b (/ n 2))))
        (else (* b (fast-exp b (- n 1))))))

(define (pseudo-remainder-terms a b)
  (let ((o1 (order (first-term a)))
        (o2 (order (first-term b)))
        (c (coeff (first-term b))))
    (cadr (/terms
            (*-term-by-all-terms
              (make-term 0 (fast-exp c (+ 1 (- o1 o2))))
              a)
            b))))

(define (gcd-all-coeffs tl acc)
  (if (empty-termlist? tl)
      acc
      (gcd-all-coeffs (rest-terms tl)
                      (gcd acc (coeff (first-term tl))))))

(define (reduce n d)
  (let ((pgcd (pseudo-gcd-terms n d)))
    (let ((o1 (max (order (first-term n))
                   (order (first-term d))))
          (o2 (order (first-term pgcd)))
          (c (coeff (first-term pgcd))))
      (let ((factor (make-term 0 (fast-exp c (+ 1 (- o1 o2))))))
        (let
          ((big-nn
             (car (/terms
                    (*-term-by-all-terms factor n)
                    (*-term-by-all-terms factor pgcd))))
           (big-dd
             (car (/terms
                    (*-term-by-all-terms factor d)
                    (*-term-by-all-terms factor pgcd)))))

          (let
            ((gcf
               (gcd (gcd-all-coeffs big-nn
                                    (coeff (first-term big-nn)))
                    (gcd-all-coeffs big-dd
                                    (coeff (first-term big-dd))))))
            (cons
              (*-term-by-all-terms (make-term 0 (/ 1 gcf))
                                   big-nn)
              (*-term-by-all-terms (make-term 0 (/ 1 gcf))
                                   big-dd))))))))
