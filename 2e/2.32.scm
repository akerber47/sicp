(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (r) (cons (car s) r)) rest)))))

; For each element, the subsets fall into 2 groups: those which contain that
; element and those which do not. We can construct the subsets which do by
; taking those which don't (which are all possible subsets of the remaining
; elements) and adding in our first element. This is precisely what we do by
; mapping over rest and appending.
