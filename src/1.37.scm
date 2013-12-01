; (a)
(define (cont-frac n d k)
  (define (cont-frac-starting-at i n d k)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (cont-frac-starting-at (+ i 1) n d k)))))
  (cont-frac-starting-at 1 n d k))

(define (phi-approx k)
  (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k))

; (b) 
(define (cont-frac-iter n d k)
  (define (cont-frac-acc n d k acc)
    (if (< k 1)
        acc
        (cont-frac-acc n d (- k 1) (/ (n k) (+ (d k) acc)))))
  (cont-frac-acc n d k 0))

; > (phi-approx 2)
; 0.5
; > (phi-approx 3)
; 0.6666666666666666
; > (phi-approx 4)
; 0.6000000000000001
; > (phi-approx 5)
; 0.625
; > (phi-approx 6)
; 0.6153846153846154
; > (phi-approx 7)
; 0.6190476190476191
; > (phi-approx 8)
; 0.6176470588235294
; > (phi-approx 9)
; 0.6181818181818182
; > (phi-approx 10)
; 0.6179775280898876
; > (phi-approx 11)
; 0.6180555555555556
; > (phi-approx 12)
; 0.6180257510729613
