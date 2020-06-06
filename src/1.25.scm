; (a)
(define (product term a next b)
  (if (> a b)
      0
      (* (term a)
         (product term (next a) next b))))

(define (inc n) (+ n 1))
(define (identity x) x)

(define (factorial n) (product identity 1 inc n))

(define (pi-prod b)
  (define (pi-term n)
    (/ (* n (+ n 2)) (* (+ n 1) (+ n 1))))
  (define (pi-next n)
    (+ n 2))
  (product pi-term 2 pi-next b))

; (b)
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))
