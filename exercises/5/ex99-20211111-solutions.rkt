#lang racket
(define head car)
(define tail cdr)
; Полезни функции:
; length, reverse, map, filter, foldr, member
; all?, any?, count, minimum, maximum
; minimumBy/maximumBy, sort, sortBy
; take, drop, range, zip

;(define (getPairs lst)
;  (if (null? lst) '()
;      (zip lst (tail lst))))

(define (minimum lst)
  (foldr min (head lst) (tail lst)))
; подаваме < за минимум, > за максимум
; (съотв. нещо със семантиката на < за
; минимум по специфичен критерий)
(define (extremumBy cmp lst)
  (foldr (lambda (el res) (if (cmp el res) el res))
         (head lst)
         (tail lst)))
; Аналогично - сортировка с предоставен предикат
(define (quicksort cmp lst)
  (if (or (null? lst) (null? (tail lst)))
      lst
      (append (quicksort cmp (filter (lambda (x) (cmp x (head lst)))
                                     (tail lst)))
              (list (head lst))
              (quicksort cmp (filter (lambda (x) (not (cmp x (head lst))))
                                     (tail lst))))))
; Зад.: списък от подинтервалите на най-дългия интервал
; Бонус: сортирани по началното си
(define (length-interval i)
  (- (cdr i) (car i)))
(define (>-interval i1 i2)
  (> (length-interval i1) (length-interval i2)))
(define (longest-interval lst)
  (extremumBy >-interval lst))

(define (sub? i1 i2)
  (and (>= (car i1) (car i2)) (<= (cdr i1) (cdr i2))))
(define (<-start i1 i2)
  (< (car i1) (car i2)))
(define (longest-interval-subsets lst)
  (let* [(longest (longest-interval lst))
         (subsets (filter (lambda (i) (sub? i longest)) lst))]
    (quicksort <-start subsets)))

; Зад.: намиране на корена на монотонна функция в интервал
; Инварианта: корен в интервала със сигурност съществува
; <=> (f a) и (f b) са с различни знаци
(define (get-root f a b)
  (let [(mid (/ (+ a b) 2))]
    (cond [(< (- b a) (expt 10 -6)) (exact->inexact mid)]
          [(negative? (* (f a) (f mid)))
           (get-root f a mid)]
          [else (get-root f mid b)])))

; Помощни функции за работа с цифри и делимост
(define (get-last n) (remainder n 10))
(define (remove-last n) (quotient n 10))
(define (divides? n d) (zero? (remainder n d)))
; Зад.1, Вар.Б, примерно контролно (2019/20)
(define (sum-digit-divisors n)
  (define (loop n res)
    (cond [(zero? n) res]
          [(zero? (get-last n)) (loop (remove-last n) res)]
          [(divides? n (get-last n))
           (loop (remove-last n) (+ res (get-last n)))]
          [else (loop (remove-last n) res)]))
  (loop n 0))

(define (1+ x) (+ x 1))
(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))
; връща броя m < n <= b, т.че m и n са в "двойка"
(define (count-ns m a b)
  (accumulate + 0
              (+ m 1) b
              (lambda (n)
                (if (= (sum-digit-divisors m)
                       (sum-digit-divisors n))
                    1 0))
              1+))
(define (same-sum a b)
  (accumulate + 0
              a (- b 1)
              (lambda (m) (count-ns m a b))
              1+))

; Зад.2, Вар.Б, примерно контролно (2019/20)
(define (all? p? lst)
  (foldr (lambda (el res) (and (p? el) res)) #t lst))
(define (all-equal? lst)
  (all? (lambda (x) (equal? x (head lst)))
        (tail lst)))
(define (get-best ml l)
  ; Бонус за който открие защо не работи (!)
  ;(define (>-metric m1 m2)
  ;  (if (> (m1 l) (m2 l)) m1 m2))
  ;(extremumBy >-metric ml))
  (define (loop ml res)
    (cond [(null? ml) res]
          [(> ((head ml) l) (res l))
           (loop (tail ml) (head ml))]
          [else (loop (tail ml) res)]))
  (loop (tail ml) (head ml)))
        
(define (best-metric? ml ll)
  (all-equal? (map (lambda (l) (get-best ml l)) ll)))

(define (sum l) (apply + l))
(define (prod l) (apply * l))

; Трябва да връща #f (!)
; (best-metric? (list car sum)  '((100 -100) (29 1) (42)))





