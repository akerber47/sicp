(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (add-2h x) (+ (* 2 h) x))
  (* (/ h 3)
     (+ (f a)
        (* 4 (sum f (+ a h) add-2h (- b h)))
        (* 2 (sum f (+ a h h) add-2h (- b h h)))
        (f b))))

; Simpson's rule works perfectly on polynomials of degree <= 3
; > (simpsons cube 0 1 100)
; 1/4
; > (simpsons cube 0 1 1000)
; 1/4
;
