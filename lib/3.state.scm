(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (-1+ trials-remaining) (1+ trials-passed)))
          (else
           (iter (-1+ trials-remaining) trials-passed))))
  (iter trials 0))

(define (real-random low high)
  (let ((range (- high low)))
    (+ low
       (/ (random (round (* 10000 range)))
          10000.0))))
