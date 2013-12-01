(define (cc amount coin-values)
  (define (except-first-denomination coin-values)
    (cdr coin-values))
  (define (first-denomination coin-values)
    (car coin-values))
  (define (no-more? coin-values) (null? coin-values))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
; > (cc 100 us-coins)
; 292
; > (cc 100 (list 10 1 25 50 5))
; 292
; No, the order doesn't matter. Each combination of coin choices is counted
; only once, just in a different order (because our count-change procedure is
; mathematically correct!)
