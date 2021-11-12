#lang racket
(define head car)
(define tail cdr)

; Зад.1 - четири решения
(define (uniques lst)
  (if (null? lst) '()
      (cons (head lst)
            (uniques (filter (lambda (x)
                               (not (equal? x (head lst))))
                             (tail lst))))))
(define (uniques* lst)
  (define (loop lst res)
    (cond [(null? lst) res]
          [(member (head lst) res) (loop (tail lst) res)]
          [else (loop (tail lst) (cons (head lst) res))]))
  (loop lst '()))

(define (uniques** l)
  (cond [(null? l) l]
        [(member (head l) (tail l)) (uniques (tail l))]
        [else (cons (head l) (uniques (tail l)))]))

(define (uniques*** lst)
  (foldr (lambda (el res)
           (if (member el res) res (cons el res)))
         '()
         lst))

; Зад.2
(define (insert val lst)
  (cond [(null? lst) (list val)]
        [(< val (head lst)) (cons val lst)]
        [else (cons (head lst) (insert val (tail lst)))]))
; Зад.3
(define (insertion-sort lst)
  ;(if (null? lst) '()
  ;    (insert (head lst) (insertion-sort (tail lst)))))
  (foldr insert '() lst))

; Зад.4
(define (begins-with? lst1 lst2)
  (or (null? lst1)
      (and (not (null? lst2))
           (equal? (head lst1) (head lst2))
           (begins-with? (tail lst1) (tail lst2)))))
  ;(cond [(null? lst1) #t]
  ;      [(null? lst2) #f]
  ;      [(equal? (head lst1) (head lst2))
  ;       (begins-with? (tail lst1) (tail lst2))]
  ;      [else #f]
(define (sublist? needle haystack)
  (and (not (null? haystack))
       (or (begins-with? needle haystack)
           (sublist? needle (tail haystack)))))
  ;(cond [(null? haystack) #f]
  ;      [(begins-with? needle haystack) #t]
  ;      [else (sublist? needle (tail haystack))]))

; Зад.5 - вариант с "натрупване" стойност по стойност
(define (add x val lst)
  (if (null? lst) (list (list val (list x)))
      (let* [(first-pair (head lst))
             (rest-pairs (tail lst))
             (first-val (head first-pair))
             (first-xs (head (tail first-pair)))]
        (if (equal? val first-val)
            (cons (list first-val
                        (cons x first-xs))
                  rest-pairs)
            (cons first-pair
                  (add x val rest-pairs))))))

(define (group-by f lst)
  (foldr (lambda (el res)
           (add el (f el) res))
         '()
         lst))
; Зад.5 - вариант със серия от трансформации
(define (group-by* f lst)
  (let* [(values (map f lst))
         (unique-values (uniques*** values))]
    (map (lambda (val)
           (list val (filter (lambda (x)
                               (equal? (f x) val))
                             lst)))
         unique-values)))

; Зад.6
; от предишни обяснения
(define (compose f g)
  (lambda (x) (f (g x))))
(define (id x) x)
(define (compose-n . fns)
  (foldr compose id fns))

; Зад.7
(define (any? p? lst)
  (foldr (lambda (el res) (or (p? el) res)) #f lst))
; Напомняне: функции с произв. брой аргументи се извикват с apply
(define (zipWith* f . lsts)
  (if (or (null? lsts) (any? null? lsts)) '()
      (cons (apply f (map head lsts))
            (apply zipWith* f (map tail lsts)))))
      
; Алтернатива (но работи само за списъци с равни дължини)
; (define zipWith* map)
; Пример: (map + '(1 2 3) '(4 5 6)) -> '(5 7 9)

; Зад.8
(define (all? p? lst)
  (not (any? (lambda (x) (not (p? x))) lst)))
(define (dependent? row1 row2)
  ; Коефициентът за гаусова трансформация
  (define coeff (- (/ (head row2) (head row1))))
  (all? zero? (gauss row1 row2)))

; Зад.8.5
; Тази задача е силно аналогична на uniques :)
(define (pseudorank m)
  (length (foldr (lambda (el res)
                   (if (any? (lambda (row) (dependent? el row)) res)
                       res
                       (cons el res)))
                 '()
                 m)))

; Зад.9
(define (gauss row1 row2)
  (let [(coeff (- (/ (head row2) (head row1))))]
    (zipWith* (lambda (x y) (+ (* coeff x) y))
              row1
              row2)))

(define (head-rows m) (head m))
(define (head-cols m) (map head m))
(define (tail-rows m) (tail m))
(define (tail-cols m) (map tail m))
(define (null-m? m) (or (null? m) (null? (head m))))

; Идея: трансформираме постепенно в горно-триъгълна
; матрица и умножаваме числата по главния диагонал.
; Проблем - може да не работи при 0 по първи диагонал :(
; Напр. ако след гаусова елиминация на първи стълб се получи
; '((1 2 3)
;   (0 0 5)
;   (0 2 4))
(define (determinant m)
  ; Прави гаусова елиминация на цял първи стълб
  ; и връща подматрицата без първи ред и първи стълб
  (define (gauss-step m)
    (tail-cols (map (lambda (row) (gauss (head-rows m) row)) (tail-rows m))))
  (if (null-m? m) 1
      (* (head (head-rows m))
         (determinant (gauss-step m)))))