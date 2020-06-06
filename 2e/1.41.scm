(define (double f)
  (lambda (x) (f (f x))))

; (((double (double double)) inc) 5)
; => (((double (lambda (x) (double (double x)))) inc) 5)
; => (((lambda (x) ((lambda (x0) (double (double x0)))
;                   ((lambda (x1) (double (double x1)))
;                    x)))
;      inc) 5)
; => ((double (double (double (double inc)))) 5)
; => 21
