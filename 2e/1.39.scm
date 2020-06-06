(define (cont-frac n d k)
  (define (cont-frac-starting-at i n d k)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (cont-frac-starting-at (+ i 1) n d k)))))
  (cont-frac-starting-at 1 n d k))

(define (tan-cf (x k))
  (cont-frac (lambda (i)
               (if (= i 1)
                   x
                   (- (* x x))))
             (lambda (i)
               (- (* 2 i) 1))
             k))
