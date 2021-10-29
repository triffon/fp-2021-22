#lang racket
; Зад.0
(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))

(define (accumulate-i op nv a b term next)
  (define (loop curr res)
    (if (> curr b) res
        (loop (next curr) (op res (term curr)))))
  (loop a nv))

(define (compose f g)
  (lambda (x) (f (g x))))
(define (constantly c)
  (lambda (x) c))
(define (1+ x) (+ x 1))
(define (id x) x)

; Зад.1
(define (nchk n k)
  (accumulate * 1 0 (- k 1)
              (lambda (i) (/ (- n i) (- k i)))
              1+))

; Зад.2
(define (2^ n)
  (accumulate-i * 1 1 n (constantly 2) 1+))
(define (2^* n)
  (accumulate + 0 0 n (lambda (k) (nchk n k)) 1+))

; Зад.3
(define (all? p? a b)
  (accumulate (lambda (x y) (and x y))
              #t
              a b
              p? 1+))
(define (any? p? a b)
  (accumulate (lambda (x y) (or x y))
              #f
              a b
              p? 1+))

;(define (next i)
;  (if (zero? (remainder n (+ i 1))) (+ i 1)
;      (next (+ i 1))))


(define (filter-accum p? op nv a b term next)
  (cond ((> a b) nv)
        ((p? a) (op (term a)
                    (filter-accum p? op nv (next a) b term next)))
        (else       (filter-accum p? op nv (next a) b term next))))

; Зад.4
(define (divisors-sum n)
  (filter-accum (lambda (i) (zero? (remainder n i)))
                + 0
                1 n
                id 1+))

; Зад.5
(define (count p? a b)
  (accumulate + 0
              a b
              (lambda (i) (if (p? i) 1 0))
              1+))
; по-доброто решение:
(define (count* p? a b)
  (filter-accum p? + 0 a b (constantly 1) 1+))

; Зад.6
(define (divides? n)
  (lambda (d) (zero? (remainder n d))))
(define (prime? n)
  (and (> n 1)
       (zero? (count (divides? n) 2 (sqrt n)))))

; Зад.7
(define (repeat n f)
  (accumulate compose id 1 n (constantly f) 1+))

; Зад.8
(define (derive f)
  (let [(dx 0.01)]
    (lambda (x) (/ (- (f (+ x dx)) (f x)) dx))))

(define (derive-n n f)
  ((repeat n derive) f))

(define (derive-n* n f)
  (accumulate (lambda (f x) (f x)) ; просто апликация
              ; (lambda (x f) (f x)) ; за итеративния
              f
              1 n
              (constantly derive) ; (!)
              1+))
