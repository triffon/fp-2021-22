#lang r5rs

(define (o f g)
  (lambda (x) (f (g x))))

; non-iterative
;(define (repeated n f x)
;  (if (= n 0)
;      x
;      (f (repeated (- n 1) f x))))

; iterative
;(define (repeated n f x)
;  (define (apply n x start)
;    (if (= start n)
;        x
;        (apply n (f x) (+ start 1) )))
;  (apply n x 0))

; also iterative
(define (repeated n f x)
  (if (= n 0)
      x
      (repeated (- n 1) f (f x))))

(define (repeat n f)
  (if (= n 0)
      (lambda (x) x)
      (o f (repeat (- n 1) f))))

; these can be defined via each other
;(define (repeated n f x)
;  ((repeat n f) x))

;(define (repeat n f)
;  (lambda (x) (repeated n f x)))


(define (accumulate op init f begin end)
  (if (> begin end)
      init
      (op (f begin) (accumulate op init f (+ begin 1) end))))

(define (count p a b)
  (accumulate + 0 (lambda (x) (if (p x) 1 0)) a b))
  

