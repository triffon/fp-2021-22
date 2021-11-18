#lang racket
; "Интерфейс" за работа със списъци
(define head car)
(define tail cdr)

; Зад.0
(define (my-append lst1 lst2)
  (if (null? lst1) lst2
      (cons (head lst1)
            (my-append (tail lst1) lst2))))

; бавен, квадратичен reverse !!!
(define (my-reverse lst)
  (if (null? lst) '()
      (append (my-reverse (tail lst))
              (list (head lst)))))
; 1 + 2 + 3 + ... + (n-1) = n^2

(define (my-reverse* lst)
  (define (loop lst res)
    (if (null? lst) res
        (loop (tail lst) (cons (head lst) res))))
  (loop lst '()))

(define (my-map f lst)
  (if (null? lst) '()
      (cons (f (head lst))
            (my-map f (tail lst)))))
(define (my-filter p? lst)
  (cond [(null? lst) '()]
        [(p? (head lst)) (cons (head lst)
                               (my-filter p? (tail lst)))]
        [else (my-filter p? (tail lst))]))
(define (my-foldr op nv lst)
  (if (null? lst) nv
      (op (head lst) (my-foldr op nv (tail lst)))))

; Истинско ляво сгъване (!)
(define (my-foldl op nv lst)
  (define (loop res lst)
    (if (null? lst) res
        (loop (op res (head lst)) (tail lst))))
  (loop nv lst))

(define (my-length lst)
  (foldr (lambda (el res) (+ 1 res)) 0 lst))
; не използваме "счупения" вграден foldl 
(define (my-length* lst)
  (my-foldl (lambda (res el) (+ 1 res)) 0 lst))
(define (my-reverse** lst)
  (my-foldl (lambda (res el) (cons el res)) '() lst))

(define (my-map* f lst)
  (foldr (lambda (el res) (cons (f el) res)) '() lst))
(define (my-filter* p? lst)
  (foldr (lambda (el res) (if (p? el) (cons el res) res)) '() lst))
; Пример за "насъбиране" на опашката на списък към първия му елемент
; - тогава по дефиниция minimum няма да работи с празни списъци
(define (minimum lst) ; (apply min lst)
  (foldr min (head lst) (tail lst)))

; Зад.1
(define (take n lst)
  (if (or (null? lst) (zero? n)) '()
      (cons (head lst) (take (- n 1) (tail lst)))))
(define (drop n lst)
  (if (or (null? lst) (zero? n)) lst ; (!)
      (drop (- n 1) (tail lst))))

; Зад.2
(define (all? p? lst)
  (foldr (lambda (el res) (and (p? el) res)) #t lst))
(define (any? p? lst)
  (not (all? (lambda (x) (not (p? x))) lst)))

; Зад.3
(define (zip lst1 lst2) (zipWith cons lst1 lst2))

; Зад.4
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2)) '()
      (cons (f (head lst1) (head lst2))
            (zipWith f (tail lst1) (tail lst2)))))

; Зад.5
; Полезна помощна функция
(define (getPairs lst)
  (if (null? lst) '()
      (zip lst (tail lst))))
(define (sorted? lst)
  (all? (lambda (p) (<= (car p) (cdr p)))
        (getPairs lst)))
; "Нормалната" имплементация
(define (sorted?? lst)
  (or (null? lst)
      (null? (tail lst))
      (and (<= (head lst) (head (tail lst)))
           (sorted?? (tail lst)))))



