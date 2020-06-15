(define (constant? x) (number? x))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond
    ((and (number? a1) (number? a2))
     (+ a1 a2))
    ((and (number? a1) (= a1 0))
     a2)
    ((and (number? a2) (= a2 0))
     a1)
    (else
      (list '+ a1 a2))))

(define (make-product a1 a2)
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
      (list '* a1 a2))))

(define (sum? x)
  (and (not (atom? x)) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (not (atom? x)) (eq? (car x) '*)))

(define (multiplier s) (cadr s))

(define (multiplicand s) (caddr s))

(define (deriv e v)
  (cond ((constant? e) 0)
        ((variable? e)
         (if (same-variable? e v) 1 0))
        ((sum? e)
         (make-sum (deriv (addend e) v)
                   (deriv (augend e) v)))
        ((product? e)
         (make-sum
           (make-product
             (multiplier e)
             (deriv (multiplicand e) v))
           (make-product
             (deriv (multiplier e) v)
             (multiplicand e))))))
