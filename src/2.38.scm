(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (lookup key record-tree)
  (cond
    ((null? record-tree) #f)
    ; should be (key (entry (record-tree))), but no key type!
    ((= key (entry record-tree)) (entry record-tree))
    ((< key (entry record-tree))
     (lookup key (left-branch record-tree)))
    (else
      (lookup key (right-branch record-tree)))))
