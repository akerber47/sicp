(define (deriv-sum exp var)
  (make-sum (deriv (addend exp) var)
            (deriv (augend exp) var)))

(define (deriv-product exp var)
  (make-sum (make-product
              (multiplier exp)
              (deriv (multiplicand exp) var))
            (make-product
              (deriv (multiplier exp) var)
              (multiplicand exp))))

(define (deriv-exponential exp var)
  (make-product
    (make-product
      (base exp)
      (make-exponential (base exp) (- (exponent exp) 1)))
    (deriv (base exp) var)))

(put '+ 'deriv deriv-sum)
(put '* 'deriv deriv-product)
(put '** 'deriv deriv-exponential)
