#lang racket

; допълнително, контролно, домашно

; head, tail
(define l1 '(1 2 3 4 5))
(define l2 (cons 1 (cons 2 (cons 3 '()))))
;          (op   1 (op   2 (op   3 nv )))

(define l3 (list 1 2 3 4 "neshto" (list 1 2 3) 'dsd + '(6 7 8) (list l1)))
(define l4 (list 1 2 3 4 "neshto" 5 6))
;(car l1)
;(cdr l1)
; eq?, eqv?, equal?


;; null?
(define (null? l)
  (eq? l '()))

; list?
(define (list? x)
  (or (null? x)
      (and (pair? x) (list? (cdr x)))))

(define (infinite n)
  (cons n (infinite (+ n 1))))

; length
(define (length l)
  (if (null? l)
      0
      (+ 1 (length (cdr l)))))


(define (1+ n) (+ 1 n))
(define (square x) (* x x))
; map
(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))
; map чрез foldr
(define (map* f l)
  (foldr (lambda (x rec)
           (cons (f x) rec))
         '()
         l))

; filter
(define (filter p? l)
  (if (null? l)
      '()
      (if (p? (car l))
          (cons (car l) (filter p? (cdr l)))
          (filter p? (cdr l)))))
; filter чрез foldr
(define (filter* p? l)
  (foldr (lambda (x rec)
           (if (p? x)
               (cons x rec)
               rec))
         '()
         l))

; append
(define (append l m)
  (if (null? l)
      m
      (cons (car l) (append (cdr l) m))))
; append чрез foldr
(define (append* l m)
  (foldr cons m l))

; foldr
(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

;(foldr cons '() l)

; чрез foldr
; length

; foldl
(define (foldl op v l)
  (if (null? l)
      v
      (foldl op (op v (car l)) (cdr l))))

(define (foldl-racket op v l)
  (if (null? l)
      v
      (foldl op (op (car l) v) (cdr l))))



(define (reverse2 l)
  (if (null? l)
      '()
      (append (reverse2 (cdr l)) (list (car l)))))

; foldl в racket

(define (flip f)
  (lambda (x y)
    (f y x)))
(define (flip2 f)
  (lambda (x y)
    (f y x)))


(define (rcons x y)
  (cons y x))

(define rcons* (flip cons))
;(define push-back snoc)

(define (snoc x y)
  (append y (list x)))

(define (reverse l)
  (foldr snoc '() l))

(define (reverse* l)
  (foldl (lambda (acc x)
           (cons x acc))
         '()
         l))

(define (reverse** l)
  (foldl rcons
         '()
         l))


; any
(define (any pred? l)
  (if (null? l)
      #f
      (or (pred? (car l))
          (any pred? (cdr l)))))
(define (any* pred? l)
  (foldr (lambda (x rec) (or x rec)) #f l))
; all
(define (all pred? l)
  (foldr (lambda (x rec) (and x rec)) #t l))

; member?
(define (member? x l)
  (if (null? l)
      #f
      (if (equal? x (car l))
          #t ; l
          (member? x (cdr l)))))

(define (member?* x l)
  (and (not (null? l))
       (or (equal? x (car l))
           (member?* x (cdr l)))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))
(define (explode-digits n)
  (if (< n 10)
      (list n) ; (cons n '())
      (append (explode-digits (quotient n 10)) (list (remainder n 10)))))

(define (sum l)
  (foldr + 0 l))

(define (sum-even-digits n)
  (sum (filter even? (explode-digits n))))
; remove
; count-occurences

;;;;;;;;;;;;;

; take
; drop

; foldr1
; foldl1
; maximum

; selection-sort
; slice
; zip
; zip-with

; unique
; set operations

; chunk

;;;;;;;;;;;;;

; atom?
; count-atoms
; flatten
; deep-reverse
;
; deep-foldr
; deep-foldl
;
; var-func
