; 3.17
(define (count-pairs x)
  (define seen '())
  (define (count-pairs-rec x)
    (if (or (atom? x) (memq x seen))
        0
        (begin
          (set! seen (cons x seen))
          (+ (count-pairs-rec (car x))
             (count-pairs-rec (cdr x))
             1))))
  (count-pairs-rec x))

; 3.18
(define (find-cycle x)
  (define seen '())
  (define (find-cycle-iter x)
    (cond
      ((null? x) #f)
      ((memq x seen) #t)
      (else
        (begin
          (set! seen (cons x seen))
          (find-cycle-iter (cdr x))))))
  (find-cycle-iter x))

; 3.19
(define (find-cycle-o1 x)
  (define (find-cycle-o1-iter t h)
    (cond
      ((eq? t h) #t)
      ((or (null? t) (null? h) (null? (cdr h))) #f)
      (else (find-cycle-o1-iter (cdr t) (cddr h)))))
  (if (null? x)
      #f
      (find-cycle-o1-iter x (cdr x))))
