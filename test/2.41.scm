(define sample-tree
  (make-code-tree (make-leaf 'A 8)
                  (make-code-tree (make-leaf 'B 4)
                                  (make-code-tree
                                    (make-leaf 'D 2)
                                    (make-leaf 'C 3)))))


(define (run)
  (let ((sample-pairs
        '((A 8)
          (B 4)
          (C 3)
          (D 2))))
    (assert (equal? (generate-huffman-tree sample-pairs)
                    sample-tree))
    "All tests passed!"
  )
)

