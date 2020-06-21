(include "src/2.40.scm")
(include "src/2.41.scm")

(define song-pairs
  '((A 2)
    (BOOM 1)
    (GET 2)
    (JOB 2)
    (NA 16)
    (SHA 3)
    (YIP 10)
    (WAH 1)))

(define song
  '(
    get a job
    sha na na na na na na na na
    get a job
    sha na na na na na na na na
    wah yip yip yip yip yip yip yip yip
    sha boom))

(define song-tree (generate-huffman-tree song-pairs))

(define song-encoded (encode song song-tree))
