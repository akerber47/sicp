(include "lib/2.deriv.scm")

(define (make-exponentiation a1 a2)
  (cond
    ((and (number? a2) (= a2 0))
     1)
    ((and (number? a2) (= a2 1))
     a1)
    (else
      (list '** a1 a2))))

(define (exponentiation? x)
  (and (not (atom? x)) (eq? (car x) '**)))

(define (base s) (cadr s))

(define (exponent s) (caddr s))

(define (exp-deriv e v)
  (cond ((constant? e) 0)
        ((variable? e)
         (if (same-variable? e v) 1 0))
        ((sum? e)
         (make-sum (exp-deriv (addend e) v)
                   (exp-deriv (augend e) v)))
        ((product? e)
         (make-sum
           (make-product
             (multiplier e)
             (exp-deriv (multiplicand e) v))
           (make-product
             (exp-deriv (multiplier e) v)
             (multiplicand e))))
        ((exponentiation? e)
         (make-product
           (exponent e)
           (make-product
             (make-exponentiation (base e) (- (exponent e) 1))
             (exp-deriv (base e) v))))))
