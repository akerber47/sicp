; Point constructor and selectors
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

; (a)
; Store rectangles as top left corner + bottom right corner
(define (make-rectangle top-left bottom-right)
  (cons top-left bottom-right))
(define (top-left rect) (car rect))
(define (top-right rect) (make-point (x-point (bottom-right rect))
                                     (y-point (top-left rect))))
(define (bottom-left rect) (make-point (x-point (top-left rect))
                                       (y-point (bottom-right rect))))
(define (bottom-right rect) (cdr rect))

(define (width rect)
  (- (x-point (bottom-right rect))
     (x-point (top-left rect))))
(define (height rect)
  (- (y-point (top-left rect))
     (y-point (bottom-right rect))))

(define (perimeter rect)
  (* 2 (+ (width rect) (height rect))))
(define (area rect)
  (* (width rect) (height rect)))

; (b)
; Could also represent by storing, say, top right and bottom left corners. This
; would only change the code of make rect and the (top/bottom)-(left/right)
; functions, not any of the later perimeter / area code.
