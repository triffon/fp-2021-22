; this function adds one to its argument
(define (plus-one x)
  (+ x 1))

(define (double x)
  (* x 2))

(define (is-even? x)
  (= 0 (remainder x 2)))

(define (is-odd? x)
  (= 1 (remainder x 2)))

(define (is-odd-bool? x)
  (not (is-even? x)))

; (a ^ -b) v (b ^ -a)
(define (evaluate-bool-expression a b)
  (or
   (and a (not b))
   (and b (not a))))

(define (excluded-middle? a)
  (or a (not a)))

; (3x^2 + 4x) / (x + 3 - 4x)
(define (square x)
  (* x x))

(define (evaluate-expression x)
  (/
   (+ (* 3 (square x)) (* 4 x))
   (- (+ x 3) (* 4 x))))

(define (is-even-if? x)
  (if (= (remainder x 2) 0)
      #t ; then
      #f ; else
      ))

; max
(define (my-max a b)
  (if (< a b) b a))

; absolute value
(define (my-abs a)
  (if (>= a 0)
      a
      (- a)))

; factorial
(define (factorial x)
  (if (<= x 1)
      1
      (* x (factorial (- x 1)))))

; sum numbers up to `x`
(define (sum-up-to x)
  (if (= x 0)
      0
      (+ x (sum-up-to (- x 1)))))
