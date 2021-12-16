#lang racket

; Поток е списък, чиито елементи се оценяват отложено
; 1) '() е поток
; 2) (h. t) е поток точно когато:
;   - h е произволен елемент
;   - t е promise за поток.

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t)
                    (cons h (delay t)))))

; Ето и базовите функции за работа с потоци
; Когато ни трябва елемент от потока просто го взимаме (той е първият)
(define head car)

; Когато искаме да вземем опашката на потока, я оценяваме с force
(define (tail s)
  (force (cdr s)))

; Доста често ще искаме да взимаме елементи от поток.
; Нека видим как бихме имплементирали функцията take за потоци.
(define (stream-take n s)
  (if (or (zero? n) (null? s))
    '()
    (cons (head s)
          (stream-take (- n 1) (tail s)))))

; Имплементирайте следните функции, генериращи безкрайни потоци

; Генерира безкраен поток от стойности v
; (repeat 1)
; (1 . #<promise>)
; (stream-take 5 (repeat 1))
; (1 1 1 1 1)
(define (repeat v)
  (cons-stream v (repeat v)))

; Генерира безкрайния поток x, f(x), f(f(x)), ...
(define (iterate f x)
  (cons-stream x (iterate f (f x))))

; Генерира безкраен поток от елементите на lst
; (cycle '(1 2 3)) би създало потока:
; 1, 2, 3, 1, 2, 3, 1 ...
(define (cycle lst)
  (define (help lst-tmp)
    (if (null? lst-tmp)
      (help lst)
      (cons-stream (car lst-tmp)
                   (help (cdr lst-tmp)))))
  (help lst))
