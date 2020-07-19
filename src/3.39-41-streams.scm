(include "lib/3.streams.scm")

; 3.39
(define (accumulate-n op init streams)
  (if (empty-stream? (head streams))
      the-empty-stream
      (cons-stream
        (accumulate op init (map head streams))
        (accumulate-n op init (map tail streams)))))

; 3.40
(define (zip-with f a b)
  (if (empty-stream? a)
      the-empty-stream
      (cons-stream (f (head a) (head b))
                   (zip-with f (tail a) (tail b)))))

(define (dot-product v w)
  (accumulate + 0 (zip-with * v w)))

(define (matrix-times-vector m v)
  (map (lambda (row) (dot-product row v)) m))

(define (transpose mat)
  (accumulate-n (lambda (a b) (cons-stream a b)) the-empty-stream mat))

(define (matrix-times-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-times-vector cols row)) m)))
