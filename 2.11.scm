; Interval implementation
(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (mul-interval x y)
  (let ((x1 (lower-bound x))
        (x2 (upper-bound x))
        (y1 (lower-bound y))
        (y2 (upper-bound y)))
    (cond
      ((and (> x1 0) (> y1 0))                ; x,y all positive
       (make-interval (* x1 y1) (* x2 y2)))
      ((and (> x1 0) (< y2 0))                ; x all positive, y all negative
       (make-interval (* x2 y1) (* x1 y2)))
      ((> x1 0)                               ; x all positive, y crosses 0
       (make-interval (* x2 y1) (* x2 y2)))
      ((and (< x2 0) (> y1 0))                ; case 2, but x,y flipped
       (make-interval (* x1 y2) (* x2 y1)))
      ((and (< x2 0) (< y2 0))                ; x,y all negative
       (make-interval (* x2 y2) (* x1 y1)))
      ((< x2 0)                               ; x all negative, y crosses 0
       (make-interval (* x1 y2) (* x1 y1)))
      ((> y1 0)                               ; case 3, but x,y flipped
       (make-interval (* x1 y2) (* x2 y2)))
      ((< y2 0)                               ; case 6, but x,y flipped
       (make-interval (* x2 y1) (* x1 y1)))
      (else                                   ; both cross 0, need to compare
       (make-interval (min (* x1 y2) (* x2 y1))
                      (max (* x1 y1) (* x2 y2)))))))
