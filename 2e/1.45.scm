(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (disp-return x)
    (newline)
    (display x)
    x)
  (define (try guess)
    (newline)
    (display guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          (disp-return next)
          (try next))))
  (try first-guess))

(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (nthrt n x)
  (fixed-point-of-transform (lambda (y) (/ x (exp y (- n 1))))
                            (repeated average-damp (ceiling (sqrt n))
                            1.0))

; With only one average-damp, infinite loops
; (define (fifthrt x)
;   (fixed-point-of-transform (lambda (y) (/ x (* y y y y)))
;                             (repeated average-damp 2)
;                             1.0))
; > (fifthrt 32)
;
; 1.0
; 8.75
; 6.563864764681383
; 4.927208317654593
; 3.708979564558109
; 2.8240085645882
; 2.2437905820352078
; 1.9984601663969659
; 2.0003879268301716
; 1.9999032063285413
; 2.0000242101302668
; 1.9999939482000788
; 2.00000151299576072.0000015129957607
; > (fifthrt 243)
;
; 1.0
; 61.5
; 46.12500424664365
; 34.593766606468826
; 25.945367373309733
; 19.4591595923806
; 14.594793385991565
; 10.947433959027066
; 8.214805046373964
; 6.174443828023087
; 4.672630813721556
; 3.63191153892918
; 3.073078177552481
; 2.9859728851026204
; 3.0036722913113247
; 2.9990931378208288
; 3.000227401291857
; 2.9999431927632934
; 3.000014204498497
; 2.999996449043514
; 3.00000088774962943.0000008877496294
; Running similar tests with higher degrees:
; n = 6  requires 2 damps
; n = 7           2
; n = 8           2
; n = 9           3
; n = 10          3
; n = 15          3
; n = 16          4
; n = 20          4
; So it looks like we'll be safe for sure if we do at least sqrt(n) damps
