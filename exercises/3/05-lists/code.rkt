#lang racket

(define (len l)
  (if (null? l)
      0
      (+ 1 (len (cdr l)))))

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

(define (member? l x)
  (if (null? l)
      #f
      (if (equal? x (car l))
         #t
         (member? (cdr l) x))))

(define (at-iter n l)
  (define (iter i lst)
    (if (>= n (len l)) #f
        (if (= i n) (car lst)
            (iter (+ i 1) (cdr lst)))))
  (iter 0 l))

(define (at n l)
  (if (null? l)
      #f
      (if (= n 0)
          (car l)
          (at (- n 1) (cdr l)))))

(define (map f l)
  (if (null? l) l
      (cons (f (car l)) (map f (cdr l)))))

(define (filter p l)
  (if (null? l)
      (list)
      (let ((tail (filter p (cdr l))))
        (if (p (car l))
            (cons (car l) tail)
            tail))))

(define (push x l)
  (if (null? l)
      (list x)
      (cons (car l) (push x (cdr l)))))

(define (push2 x l)
   (append l (list x)))

(define (insert x n l)
  (if (null? l) (list x)
    (if (= n 0)
        (cons x l)
        (cons (car l) (insert x (- n 1) (cdr l))))))

(define (insert2 x n l)
  (define (iter i lst)
    (if (null? lst) (cons x lst)
        (if (= i n) (cons x lst)
            (cons (car lst) (iter (+ i 1) (cdr lst))))))
  (iter 0 l))


(define (reverse l)
  (if(null? l)
     l
     (push(car l) (reverse (cdr l)))))

(define (reverse2 l)
  (define (iter l res)
    (if (null? l)
        res
        (iter (cdr l) (cons (car l) res))))
  (iter l `()))

; also known as 'reduce' or 'foldr'
(define (accumulate l op init)
  (if(null? l)
     init
     (op (car l) (accumulate (cdr l) op init))))

; ("foo" + ("bar" + ("baz" + ""))))
(define foldr accumulate)
(define reduce accumulate)

; ((("" + "foo") + "bar") + "baz")
(define (foldl l op init)
  (if(null? l)
     init
     (foldl (cdr l) op (op init (car l)))))

(define (t s1 s2)
  (string-append "{" s1 "." s2 "}"))