#lang racket
(define head car)
(define tail cdr)

; Зад.0
(define (my-foldr op nv lst)
  (if (null? lst) nv
      (op (head lst)
          (my-foldr op nv (tail lst)))))
(define (sum lst) (foldr + 0 lst))
(define (my-length lst)
  (foldr (lambda (el res) (+ 1 res)) 0 lst))
(define (my-map f lst)
  (foldr (lambda (el res) (cons (f el) res)) '() lst))
(define (minimum lst) ;(apply min lst)
  (foldr min (head lst) (tail lst)))

; Зад.2
(define (all? p? lst)
  (foldr (lambda (el res) (and (p? el) res)) #t lst))
(define (any? p? lst)
  ;(not (null? (filter p? lst)))
  (not (all? (lambda (x) (not (p? x))) lst)))

; Зад.3
(define (zip lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (cons (head lst1) (head lst2))
            (zip (tail lst1) (tail lst2)))))

; Зад.5
(define (getPairs lst)
  (if (null? lst) '()
      (zip lst (tail lst))))
(define (sorted? lst)
  (let [(pairs (getPairs lst))]
    (all? (lambda (p) (<= (car p) (cdr p))) pairs)))

; Зад.6
(define (uniques lst)
  (cond [(null? lst) '()]
        [(member (head lst) (tail lst)) (uniques (tail lst))]
        [else (cons (head lst) (uniques (tail lst)))]))

(define (uniques* lst)
  (if (null? lst) '()
      (cons (head lst)
            (uniques* (filter (lambda (x)
                               (not (equal? x (head lst))))
                              (tail lst))))))

(define (uniques** lst)
  (foldr (lambda (el res)
           (if (member el res) res (cons el res)))
         '()
         lst))

; Зад.9
(define (interval-length i) (- (cdr i) (car i)))
(define (bigger-interval? a b)
  (> (interval-length a) (interval-length b)))
(define (maximum* cmp lst)
  (foldr (lambda (el res) (if (cmp el res) el res))
         (head lst)
         (tail lst)))
(define (longest-interval lst)
  (maximum* bigger-interval? lst))
(define (sub-interval? a b)
  (and (>= (car a) (car b)) (<= (cdr a) (cdr b))))
(define (longest-interval-subsets lst)
  (let [(longest (longest-interval lst))]
    (filter (lambda (x) (sub-interval? x longest))
            lst)))
