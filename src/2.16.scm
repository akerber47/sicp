(define (last items)
  (if (null? items)
      (error "Empty list")
      (if (null? (cdr items))
          items
          (last (cdr items)))))
