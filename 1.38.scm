(define (cont-frac n d k)
  (define (cont-frac-starting-at i n d k)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (cont-frac-starting-at (+ i 1) n d k)))))
  (cont-frac-starting-at 1 n d k))

(define (e-approx k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) (if (= (remainder i 3) 2)
                             (* (/ 2 3) (+ i 1.0))
                             1.0))
             k))

; > (e-approx 1)
; 1.0
; > (e-approx 2)
; 0.6666666666666666
; > (e-approx 3)
; 0.75
; > (e-approx 4)
; 0.7142857142857143
; > (e-approx 5)
; 0.71875
; > (e-approx 6)
; 0.717948717948718
; > (e-approx 7)
; 0.7183098591549296
; > (e-approx 8)
; 0.7182795698924731
