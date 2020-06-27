
(define (the-empty-termlist-dense) '())
(define (first-term-dense term-list)
  (make-term (- (length term-list) 1)
             (car term-list)))
(define (rest-terms-dense term-list)
  (let ((rt (cdr term-list)))
    (if (=zero? (car rt))
        (rest-terms-dense rt)
        rt)))
(define (empty-termlist?-dense term-list) (null? term-list))

(define (adjoin-term-dense term term-list)
  (cond
    ((=zero? (coeff term))
     (make-termlist-dense term-list))
    ((= (order term) (length term-list))
     (cons (coeff term) term-list))
    (adjoin-term-dense term (cons 0 term-list))))
