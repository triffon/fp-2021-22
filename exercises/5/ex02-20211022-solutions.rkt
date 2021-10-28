#lang racket

; Зад.1
;(define (toBinary n)
;  (if (zero? n) 0
;      (+ (* 10 (toBinary (quotient n 2)))
;         (remainder n 2))))
(define (toBinary n)
  ; Инварианта: idx е индекса на следващия бит
  ; за "обработване"
  (define (loop n res idx)
    (define last-bit (remainder n 2))
    (if (zero? n) res
        (loop (quotient n 2)
              (+ res (* (expt 10 idx) last-bit))
              (+ idx 1))))
  (loop n 0 0))

; Зад.2
(define (toDecimal n)
  (if (zero? n) 0
      (+ (* 2 (toDecimal (quotient n 10)))
         (remainder n 10))))

;(define (sq x) (* x x))
;(define sq (lambda (x) (* x x)))

; Зад.3
(define (constantly c)
  (lambda (x) c))
(define (flip f)
  (lambda (x y) (f y x)))
(define (complement p?)
  (lambda (x) (not (p? x))))
(define (compose f g)
  (lambda (x) (f (g x))))

; Зад.4
(define (id x) x)
(define (repeat n f)
  (if (= n 0) id
      (compose f (repeat (- n 1) f))))

; Зад.7
(define (twist k f g)
  (if (zero? k) id
      (compose f (twist (- k 1) g f))))
; Рекурсивен accumulate - дясно свиване
; (a1 + (a2 + (a3 + ... (an + nv))))
; Итеративен accumulate - ляво свиване
; (((...((nv + a1) + a2) + a3) ... + an)
; Зад.8
(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))
(define (accumulate-i op nv a b term next)
  (define (loop a res)
    (if (> a b) res
        (loop (next a) (op res (term a)))))
  (loop a nv))

(define (1+ x) (+ x 1))
(define (fact n)
  (accumulate * 1 1 n id 1+))

; Зад.9
(define (!! n)
  (accumulate * 1
              (if (odd? n) 1 2)
              n
              id
              (repeat 2 1+)))