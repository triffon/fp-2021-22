#lang racket
; Решения

; I

; a = (3 + 5 - (16 - 12)) + ((27 / 9) - (3.61 * 7))
; Трябва да получим -18.27
(define a (+ (- (+ 3 5) (- 16 12)) (- (/ 27 9) (* 3.61 7))))
; b = (7 + 9 * 11)^2
; Трябва да получим 11234
(define b (expt (+ 7 (* 9 11)) 2))


; II

(define (my-sqr x)
  (* x x)
)


(define (sum-interval a b)
  (if (> a b)
      0
      (+ a (sum-interval (+ a 1) b))
  )
)


(define (my-even? x)
  (= (remainder x 2) 0)
)


(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))
  )
)


(define (pow x n)
  (if (= 0 n)
      1
      (* x (pow x (- n 1)))
  )
)