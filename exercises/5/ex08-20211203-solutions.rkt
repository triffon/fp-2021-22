#lang racket

; (define (f x) (* x x))
; Стриктно:
; (f (+ 3 5)) -> (f 8) -> (* 8 8) -> 64
; Мързеливо:
; (f (+ 3 5)) -> (* (+ 3 5) (+ 3 5)) -> (* 8 8) -> 64
; Мързеливо, на практика:
; (define (f x) (* x x))
; -> (define (f x) (* (force x) (force x)))
; (f (+ 3 5))
; -> (f (delay (+ 3 5))) -> ... -> 64

; Пример за мързелива функция, по-ефикасна от стриктния си вариант
; (define (g x y)
;   (if (> x 5) y 0))
; (g 3 (сложен израз))
; (if (> 3 5) (сложен израз) 0) -> 0
; (g 10 (сложен израз))
; (if (> 10 5) (сложен израз) 0) -> (сложен израз)

; Специални форми, които сме виждали досега:
; if, cond, define, lambda, let, let*,
; letrec, quote, and, or, delay, define-syntax
; Заб.: force не е специална форма - няма нужда да бъде :)

; Пример - изразът се оценява само веднъж,
; колкото пъти и да извикваме (force p)
(define p
  (delay (begin (displayln "iei") 5)))

; Списъкът е наредена двойка от елемент и друг списък
; Потокът е наредена двойка от елемент и обещание
; за друг поток

; Проблем - delay е специална форма, но cons-stream
; не е и за нея важи стриктно оценяване
;(define (cons-stream h t)
;  (cons h (delay t)))
; Решение - дефинираме cons-stream като специална форма
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))
(define null-stream #f)
(define (null-stream? s) (not s)) ; само #f е #f
(define (head-stream s) (car s))
(define (tail-stream s) (force (cdr s)))

; Аналогично на map за списъци
(define (map-stream f s)
  (if (null-stream? s) null-stream
      (cons-stream (f (head-stream s))
                   (map-stream f (tail-stream s)))))

; Взимане на първите n елемента от потока s в обикновен списък
(define (take n s)
  (if (or (zero? n) (null-stream? s)) '()
      (cons (head-stream s)
            (take (- n 1) (tail-stream s)))))

(define (1+ x) (+ x 1))
; Пример за функция, генерираща безкраен поток
(define (nats-from n)
  (cons-stream n (nats-from (1+ n))))
  ; това се разпъва до
; (cons n (delay (nats-from (1+ n)))
  ; и сега вече рекурсивното извикване е отложено

; Пример за потоци, рефериращи към себе си
; (един вид рекурсивни променливи)
(define ones (cons-stream 1 ones))
(define nats
  (cons-stream 0 (map-stream 1+ nats)))

(take 10 nats) ; '(0 1 2 3 4 5 6 7 8 9)
