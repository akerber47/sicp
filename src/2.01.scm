(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
       (cond
         ((= d 0) (error "Division by 0"))
         ((< d 0) (cons (- (/ n g)) (- (/ d g))))
         (else (cons (/ n g) (/ d g))))))
