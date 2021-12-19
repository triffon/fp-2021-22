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

(define (at-l l i)
  (if (or (not (list? l)) (null? l))
     #f
     (if (> i 0)
        (at-l (cdr l) (- i 1))
        (car l))))

(define (at m i j)
  (at-l (at-l m i) j))

(define (mat-map f m)
  (map (lambda (l) (map f l)) m))

(define (list-of-numbers? l)
  (forall? l number?))

(define (mat? m)
  (and
   (list? m)
   (forall? m list?)
   (forall? m (lambda (l) (= (length l) (length (car m)))))
   (forall? m list-of-numbers?)))

(define (scalmul x m)
  (mat-map (lambda (z) (* z x)) m))

(define (transpose ls)
  (define (helper ls res)
    (if (null? (car ls)) res
    (helper (map cdr-func ls) (append res (list (map (lambda (x) (car-func x)) ls))))))
  (helper ls '()))

(define (cdr-func ls)
  (if (null? ls) '()
  (cdr ls)))

(define (car-func ls)
  (if (null? ls) '()
      (car ls)))

(define (transpose2 m)
  (if (or (null? m) (null? (car m)))
      (list)
      (cons (map car m) (transpose2 (map cdr m)))))

(define (matmul m1 m2)
  (map (lambda (x) (map (lambda (y) (dot-prod x y)) (transpose m2))) m1))

(define (dot-prod v1 v2)
  (apply + (map * v1 v2)))


; now we implement 'map' but with an arbitrary number of arguments
(define (map-single f l)
  (if (null? l) l
      (cons (f (car l)) (map-single f (cdr l)))))

(define (multimap f . args)
  (if (null? (car args))
      (list)
      (cons
       (apply f (map-single car args))
       (apply multimap (cons f (map-single cdr args))))))