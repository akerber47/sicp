(include "lib/2.huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge tree-set)
  (cond ((null? tree-set)
         '())
        ((null? (cdr tree-set))
         (car tree-set))
        (else
         (successive-merge
           (adjoin-set (make-code-tree
                         (car tree-set)
                         (cadr tree-set))
                       (cddr tree-set))))))

