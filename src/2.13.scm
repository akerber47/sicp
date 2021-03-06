; Full interval implementation
(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (error "Division by zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (make-center-width c (* c (/ p 100))))
(define (percent i)
  (* (/ (width i) (center i)) 100))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))
; Immediate discrepancy:
; > (par1 (make-center-percent 100 5) (make-center-percent 50 5))
; (mcons 28.650793650793652 38.68421052631579)
; > (center (par1 (make-center-percent 100 5) (make-center-percent 50 5)))
; 33.66750208855472
; > (percent (par1 (make-center-percent 100 5) (make-center-percent 50 5)))
; 14.900744416873446
; > (par2 (make-center-percent 100 5) (make-center-percent 50 5))
; (mcons 31.666666666666664 35.0)
; > (center (par2 (make-center-percent 100 5) (make-center-percent 50 5)))
; 33.33333333333333
; > (percent (par2 (make-center-percent 100 5) (make-center-percent 50 5)))
; 5.000000000000004
