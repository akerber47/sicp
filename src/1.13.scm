(define (* a b)
  (*-iter 0 a b))

(define (*-iter acc a b)
  (cond ((= b 0) acc)
        ((even? b) (*-iter acc (double a) (halve b)))
        (else (*-iter (+ acc a) a (- b 1)))))
