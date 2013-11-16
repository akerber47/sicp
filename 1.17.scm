(define (* a b)
  (cond ((= b 0) (a))
        ((even? b) (* (double a) (halve b)))
        (else (+ a (* a (- b 1))))))
