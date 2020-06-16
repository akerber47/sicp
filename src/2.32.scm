; part (a) ip = infix with parens
;
; NOTE: constant?, variable?, and same-variable? are unchanged.

(include "lib/2.deriv.scm")

(define (ip-make-sum a1 a2)
  (cond
    ((and (number? a1) (number? a2))
     (+ a1 a2))
    ((and (number? a1) (= a1 0))
     a2)
    ((and (number? a2) (= a2 0))
     a1)
    (else
      (list a1 '+ a2))))

(define (ip-make-product a1 a2)
  (cond
    ((and (number? a1) (number? a2))
     (* a1 a2))
    ((and (number? a1) (= a1 0))
     0)
    ((and (number? a2) (= a2 0))
     0)
    ((and (number? a1) (= a1 1))
     a2)
    ((and (number? a2) (= a2 1))
     a1)
    (else
      (list a1 '* a2))))

(define (ip-sum? x)
  (and (not (atom? x))
       (not (atom? (cdr x)))
       (eq? (cadr x) '+)))

(define (ip-addend s) (car s))

(define (ip-augend s) (caddr s))

(define (ip-product? x)
  (and (not (atom? x))
       (not (atom? (cdr x)))
       (eq? (cadr x) '*)))

(define (ip-multiplier s) (car s))

(define (ip-multiplicand s) (caddr s))

(define (ip-deriv e v)
  (cond ((constant? e) 0)
        ((variable? e)
         (if (same-variable? e v) 1 0))
        ((ip-sum? e)
         (ip-make-sum (ip-deriv (ip-addend e) v)
                      (ip-deriv (ip-augend e) v)))
        ((ip-product? e)
         (ip-make-sum
           (ip-make-product
             (ip-multiplier e)
             (ip-deriv (ip-multiplicand e) v))
           (ip-make-product
             (ip-deriv (ip-multiplier e) v)
             (ip-multiplicand e))))))

; part (b) i = infix

; We never need parentheses when adding
(define (i-make-sum a1 a2)
  (cond
    ((and (number? a1) (number? a2))
     (+ a1 a2))
    ((and (number? a1) (= a1 0))
     a2)
    ((and (number? a2) (= a2 0))
     a1)
    (else
      (let ((new-a1
              (if (list? a1) a1 (list a1)))
            (new-a2
              (if (list? a2) a2 (list a2))))
        (append new-a1 '(+) new-a2)))))

; To check if we need parentheses when multiplying,
; see if we're adding anything at the top level first.
; If so, parenthesize it.
(define (i-make-product a1 a2)
  (cond
    ((and (number? a1) (number? a2))
     (* a1 a2))
    ((and (number? a1) (= a1 0))
     0)
    ((and (number? a2) (= a2 0))
     0)
    ((and (number? a1) (= a1 1))
     a2)
    ((and (number? a2) (= a2 1))
     a1)
    (else
      (let
        ((new-a1
           (if (and (list? a1) (not (i-sum? a1)))
               a1
               (list a1)))
         (new-a2
           (if (and (list? a2) (not (i-sum? a2)))
               a2
               (list a2))))
      (append new-a1 '(*) new-a2)))))

; To find if it's a sum, need to hunt for '+.
; Use shared helper that finds a given item in a
; list a returns the before (reversed) and after lists.
(define (find-pivot pivot acc x)
  (cond
    ((atom? x) #f)
    ((eq? (car x) pivot) (cons acc (cdr x)))
    (else (find-pivot pivot (cons (car x) acc) (cdr x)))))

(define (i-sum? x)
  (if (find-pivot '+ nil x) #t #f))

(define (flatten-one l)
  (if (and (list? l) (not (atom? l)) (null? (cdr l)))
      (car l)
      l))

(define (i-addend s)
  (flatten-one (reverse (car (find-pivot '+ nil s)))))

(define (i-augend s)
  (flatten-one (cdr (find-pivot '+ nil s))))

(define (i-product? x)
  (if (not (i-sum? x))
      (if (find-pivot '* nil x) #t #f)
      #f))

(define (i-multiplier s)
  (flatten-one (reverse (car (find-pivot '* nil s)))))

(define (i-multiplicand s)
  (flatten-one (cdr (find-pivot '* nil s))))

(define (i-deriv e v)
  (cond ((constant? e) 0)
        ((variable? e)
         (if (same-variable? e v) 1 0))
        ((i-sum? e)
         (i-make-sum (i-deriv (i-addend e) v)
                     (i-deriv (i-augend e) v)))
        ((i-product? e)
         (i-make-sum
           (i-make-product
             (i-multiplier e)
             (i-deriv (i-multiplicand e) v))
           (i-make-product
             (i-deriv (i-multiplier e) v)
             (i-multiplicand e))))))

