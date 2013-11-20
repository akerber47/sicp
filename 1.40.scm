(define (cubic a b c)
  (lambda (x) (+ c (* x (+ b (* x (+ a x)))))))
