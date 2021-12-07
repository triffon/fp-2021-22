#lang racket
(require racket/stream)

;(define (ones)
;  (cons 1 (ones)))

; празен поток
; stream - (стойност, поток)
; (с1, (с2, (с3, поток)))
;(define (delay x)
;  (lambda () x)
;)
;
;(define (force x)
;  (x)
;)
;
;(define (stream-cons x y)
;  (cons x (delay y))
;)
;
;(define (stream-car s)
;  (car s)
;)
;
;(define (stream-cdr s)
;  (force (cdr s))
;)

; Потоци

; Примитиви - като за списъци
empty-stream
(define s (stream-cons 1 (stream-cons 2 empty-stream)))

(stream-first s)
(stream-first (stream-rest s))

; stream-take
(define (stream-take s n)
  (void)
)

; да направим поток с естествени числа започващи от n
(define (naturals-from n)
  (void)
)

; repeat-list - искаме поток от безброй повторения на даден списък
; '(1 2 3) -> '(1 2 3 1 2 3 1 2 3...)
(define (repeat-list xs)
  (void)
)

; iterate - искаме безкраен поток от типа (x (f x) (f (f x))...)
(define (iterate x f)
  (void)
)

; scanl - поток от типа (nv (op (nv, a1)) (op (op (nv, a1)), a2)...)
; foldl, foldr

; scanl + 0 '(1 2 3) -> '(0 1 3 6)
; (last (scanl + 0 '(1 2 3)) -> 6
(define (scanl op null-value s)
  (void)
)


; функции със случаен брой аргументи?
; apply?

; Декартово произведение на две множества (списъци)
; приемаме, че са ни дадени множества
(define (cartesian-product xs ys)
  (void)
)


; Искаме да приложим функция (на два аргумента) на два списъка
(define (apply-lists f xs ys)
  (void)
)



