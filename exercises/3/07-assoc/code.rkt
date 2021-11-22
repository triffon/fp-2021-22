#lang racket

; copy from last time
(define (exists? l p)
  (if (null? l)
      #f
      (if (p (car l))
          #t
          (exists? (cdr l) p))))

(define (forall? l p)
  (if (null? l)
      #t
      (if (p (car l))
          (forall? (cdr l) p)
          #f)))
; ***

(define assoc-empty '())

(define (assoc-empty? list)
  (null? list))

(define (contains-key? key assoc-list)
  (if (assoc-empty? assoc-list) #f
     (if(equal? key (car (car assoc-list))) #t
        (contains-key? key (cdr assoc-list)))))

(define (contains-only-pairs? l)
  (forall? l pair?))

(define (no-duplicate-keys? l)
  (if(assoc-empty? l) #t
     (if (not (contains-key? (car (car l)) (cdr l)))
         (no-duplicate-keys? (cdr l))
         #f)))

(define (assoc? l)
  (and (contains-only-pairs? l) (no-duplicate-keys? l)))

(define (assoc-set l k v)
  (if (null? l) (cons (cons k v) l)
      (if (equal? (car (car l)) k)
          (cons (cons k v) (cdr l))
          (cons (car l) (assoc-set (cdr l) k v)))))

(define (assoc-get l k)
  (if(null? l) #f
     (if(equal? k (caar l)) (cdr (car l))
        (assoc-get (cdr l) k))))

(define (assoc-map f l)
  (map (lambda (x) (cons (car x) (f (cdr x)))) l))

(define (assoc-filter p l)
  (filter (lambda (x) (p (cdr x))) l))

(define (assoc-merge l1 l2)
  (if (null? l2) l1
      (assoc-merge (assoc-set l1 (caar l2) (cdar l2)) (cdr l2))))

(define (forall-values? l p)
  (forall? l (lambda (x) (p (cdr x)))))
