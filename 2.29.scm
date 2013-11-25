(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))
; (a)
(define (left-branch m) (car m))
(define (right-branch m) (cadr m))
(define (branch-length b) (car b))
(define (branch-structure b) (cadr b))
(define (is-mobile? structure) (pair? structure))
; (b)
(define (total-weight m)
  (if (is-mobile? m)
      (+ (total-weight (branch-structure (left-branch m)))
         (total-weight (branch-structure (right-branch m))))
      m))
; (c)
(define (is-balanced? m)
  (if (is-mobile? m)
      (and (= (* (branch-length (left-branch m))
                 (total-weight (branch-structure (left-branch m))))
              (* (branch-length (right-branch m))
                 (total-weight (branch-structure (right-branch m)))))
           (is-balanced? (branch-structure (left-branch m)))
           (is-balanced? (branch-structure (right-branch m))))
      #t))
; (d)
; Only need to change part (a): change 'cadr' to 'cdr'
