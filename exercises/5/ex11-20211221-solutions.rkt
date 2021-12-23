#lang racket
(define head car)
(define tail cdr)

; Стандартни, полезни функции
(define (all? p? lst)
  (or (null? lst)
      (and (p? (head lst))
           (all? p? (tail lst)))))
(define (any? p? lst)
  (not (none? p? lst)))
(define (none? p? lst)
  (all? (lambda (x) (not (p? x))) lst))

; Примерен ацикличен граф
(define G '((0 1 3)
            (1 2 5)
            (2)
            (3 4 5)
            (4 5)
            (5)))
; Интерфайс за графи, използващ представянето тип "асоциативен списък"
(define (vertices g) (map head g))
(define (children u g)
  (define (tail-#f x)
    (if x (tail x) #f))
  (tail-#f (assoc u g))) ; в случай на невалиден вход
(define (edge? u v g)
  (member v (children u g)))
(define (parents u g)
  (filter (lambda (v) (edge? v u g)) (vertices g)))
; [ v | v<-vertices g, edge? v u g ]

; Зад.1а)
(define (family? f g)
  ; Локални помощни функции
  (define (all-in-f? lst)
    (all? (lambda (x) (member x f)) lst))
  (define (none-in-f? lst)
    (none? (lambda (x) (member x f)) lst))
  (all? (lambda (u)
          (or (and (all-in-f? (parents u g))
                   (none-in-f? (children u g)))
              (and (all-in-f? (children u g))
                   (none-in-f? (parents u g)))))
        f))

; ((1 2 3) (4) (5 6)) -> (1 2 3 4 5 6)
; В Хаскел е вградена
(define (concat lsts) (apply append lsts))
(define (uniques lst)
  (foldr (lambda (el res)
           (if (member el res) res (cons el res)))
         '()
         lst))
; Понякога са полезни и операции като с множества
; lst1 . lst2
(define (set-intersect lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))
; lst1 / lst2
(define (set-difference lst1 lst2)
  (filter (lambda (x) (not (member x lst2))) lst1))

; Зад.1б)
(define (min-including u g)
  (define (helper curr all flag)
    (let* [(next** (map (lambda (u)
                          ((if flag parents children) u g))
                        curr))
           (next* (uniques (concat next**)))
           (next (set-difference next* all))]
      (if (null? next) all
          (helper next (append all next) (not flag)))))
  ; Може би има и по-елегантни начини, не се сетих на момента
  (let [(try1 (helper (list u) (list u) #t))
        (try2 (helper (list u) (list u) #f))]
    (cond [(family? try1 g) try1]
          [(family? try2 g) try2]
          [else #f])))

; Зад.2
; Можем да изброим всички подмножества върхове
; и да изберем най-доброто подходящо измежду тях.
(define (subsets lst)
  (if (null? lst) (list '())
      (let [(rest (subsets (tail lst)))]
        (append rest (map (lambda (s)
                            (cons (head lst) s))
                          rest)))))
; (define (subsets lst) (combinations lst)) в Racket

; Зад.3
; Добавяне на двойка ключ-стойност в асоциативен списък
(define (add-assoc k v lst)
  (cond [(null? lst) (list (list k v))]
        [(and (equal? k (head (head lst)))
              (member v (tail (head lst))))
         lst]
        [(equal? k (head (head lst)))
         (cons (cons k (cons v (tail (head lst))))
               (tail lst))]
        [else (cons (head lst)
                    (add-assoc k v (tail lst)))]))

; Зад.4
(define e '((0 . 1) (0 . 2) (1 . 2) (2 . 3) (1 . 3)))
; Проблем: ако от връх няма излизащи ребра, няма да го включи
(define (edges-to-neighbs edges)
  (foldr (lambda (el res)
           (add-assoc (car el) (cdr el) res))
         '()
         e))
; Решение - събираме всички споменати върхове
; и правим асоциативен списък с тях като ключове, но без стойности.
(define (all-vertices e) ; (0 1 2 3)
  (uniques (append (map car e) (map cdr e))))
(define (edges-to-neighbs* edges)
  (let [(all-vertices ; (0 1 2 3)
         (uniques (append (map car e) (map cdr e))))]
    (foldr (lambda (el res)
             (add-assoc (car el) (cdr el) res))
           (map list all-vertices) ; ((0) (1) (2) (3))
           e)))
