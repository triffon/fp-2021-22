#lang racket
(define head car)
(define tail cdr)
; Стандартен "интерфейс"
(define empty-tree '())
(define (make-tree root left right) (list root left right))      ; не искаме просто (define make-tree list) - защо?
(define (make-leaf root) (make-tree root empty-tree empty-tree)) ; за удобство
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define test-tree
  (make-tree 10
             (make-tree 7
                        (make-leaf 10)
                        (make-leaf 2))
             (make-tree 3
                        (make-tree 4
                                   (make-leaf 1)
                                   (make-leaf 2))
                        empty-tree)))

; Зад.1
(define (height t)
  (if (empty-tree? t) 0
      (+ 1 (max (height (left-tree t))
                (height (right-tree t))))))

; Зад.2
(define (get-level n t)
  (cond [(empty-tree? t) '()]
        [(zero? n) (list (root-tree t))]
        [else (append (get-level (- n 1) (left-tree t))
                      (get-level (- n 1) (right-tree t)))]))
; Бонус:
(define (all-levels t)
  (map (lambda (i) (get-level i t))
       (range 0 (height t))))

; Зад.3
(define (get-longest-path t)
  (if (empty-tree? t) '()
      (let [(left (get-longest-path (left-tree t)))
            (right (get-longest-path (right-tree t)))]
        (cons (root-tree t)
              (if (> (length left) (length right)) left right)))))

; Зад.4
(define (tree-map f t)
  (if (empty-tree? t) empty-tree
      (make-tree (f (root-tree t))
                 (tree-map f (left-tree t))
                 (tree-map f (right-tree t)))))

; Зад.5
(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))

; Зад.6
(define (bst-insert cmp val t)
  (cond [(empty-tree? t) (make-leaf val)]
        [(cmp val (root-tree t))
         (make-tree (root-tree t)
                    (bst-insert cmp val (left-tree t))
                    (right-tree t))]
        [else (make-tree (root-tree t)
                         (left-tree t)
                         (bst-insert cmp val (right-tree t)))]))

; Зад.7
(define (list->tree cmp lst)
  (foldl (lambda (el res)
           (bst-insert cmp el res))
         empty-tree lst))

(define (tree-sort cmp lst)
  (tree->list (list->tree cmp lst)))

; Полезен пример за когато сравняваме по критерий,
; "скъп" за пресмятане при всяко сравнение (напр. дължина на списък).
; Решение: слагаме всеки елемент в наредена двойка
; с преизчислената си стойност и сортираме "бързо".
(define (sort-on f lst)
  (map cdr (tree-sort
            (lambda (x y) (< (car x) (car y)))
            (map (lambda (x) (cons (f x) x)) lst))))


; Зад.8 - ГРЕШНА
; Служи само за пример как да обработваме
; липсващи поддървета без повторение на код
;(define (bst-valid? t)
;  (if (empty-tree? t) #t
;      (let [(l (left-tree t))
;            (r (right-tree t))]
;        (and (or (empty-tree? l)
;                 (and (>= (root-tree t) (root-tree l))
;                      (bst-valid? l)))
;             (or (empty-tree? r)
;                 (and (<= (root-tree t) (root-tree r))
;                      (bst-valid? r)))))))

(define (bst-valid? t)
  ; Проверява дали всички елементи на t са в [a;b]
  ; a е число или #f за -безкр
  ; b е число или #f за +безкр
  (define (helper t a b)
    (if (empty-tree? t) #t
        (let [(x (root-tree t))]
          (and (or (not a) (>= x a)) ; ако е число, иначе със сигурност е >= -безкр
               (or (not b) (<= x b))
               (helper (left-tree t) a x) ; стесняваме интервала
               (helper (right-tree t) x b)))))
  (helper t #f #f))

; Зад.12
(define (same-as-code t)
  ; Получава число от списък с битове в обратен ред
  ; - защото е по-удобно да ги добавяме с cons :)
  (define (from-code code)
    (foldr (lambda (el res) (+ el (* 2 res))) 0 code))
  (define (helper t code)
    (if (empty-tree? t) '()
        (let [(x (root-tree t))]
          (append (helper (left-tree t) (cons 0 code))
                  (if (= x (from-code code)) (list x) '())
                  (helper (right-tree t) (cons 1 code))))))
  (helper t '(1)))
                      
                      
                      