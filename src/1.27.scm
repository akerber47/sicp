(define (filtered-accumulate filt combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filt a)
                    (term a)
                    null-value)
                (accumulate filt combiner null-value term (next a) next b))))

; These won't actually run, as I'm too lazy to copy over all the definitions
; they depend on.
(define (sum-sq-prime a b)
  (filtered-accumulate prime? + 0 square a inc b))
(define (prod-rel-prime n)
  (define (rel-prime? i)
    (= (gcd i n) 1))
  (filtered-accumulate rel-prime? * 1 identity 1 inc n))
