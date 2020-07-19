; Note: main stream interface (section 3.4.3)
; is already built into MIT scheme
; but with some slightly different names

(define head stream-car)
(define tail stream-cdr)
(define empty-stream? stream-null?)
(define the-empty-stream (stream))

(define (accumulate combiner initial-value stream)
  (if (empty-stream? stream)
      initial-value
      (combiner (head stream)
                (accumulate combiner
                            initial-value
                            (tail stream)))))

(define (enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low (enumerate-interval (1+ low) high))))

(define map stream-map)

(define (filter pred stream)
  (cond ((empty-stream? stream) the-empty-stream)
        ((pred (head stream))
         (cons-stream (head stream)
                      (filter pred (tail stream))))
        (else (filter pred (tail stream)))))

(define (append-streams s1 s2)
  (if (empty-stream? s1)
      s2
      (cons-stream (head s1)
                   (append-streams (tail s1) s2))))

(define (flatten stream)
  (accumulate append-streams the-empty-stream stream))

(define (flatmap f s) (flatten (map f s)))

(define (print-stream stream)
  (write-string "\n{")
  (write (stream->list stream))
  (write-string "}"))
