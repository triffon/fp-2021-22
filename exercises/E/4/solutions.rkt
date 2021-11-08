#lang racket

; combine-numbers ?

; вградена функция, която прави същото - length
(define (my-length l)
  (if (null? l)
      0
      (+ 1 (my-length (cdr l)))
  )
)

; вградена функция, която прави същото - list-ref
(define (nth l n)
  (define (helper current-l i)
    (if (= i n)
        (car current-l)
        (helper (cdr current-l)
                    (+ i 1))))
  (helper l 0))


(define (count-occurs x l)
  (cond
    ((null? l) 0)
    ((eqv? x (car l)) (+ 1 (count-occurs x (cdr l))))
    (else (count-occurs x (cdr l)))
)

(define (my-append l1 l2)
  (if (null? l1)
    l2
    (cons (car l1) (my-append (cdr l1) l2))
  )
)

(define (push-back x l)
  (if (null? l)
      (list x)
      (cons (car l) (push-back x (cdr l)))
  )
)

(define (take n l)
  (if (= n 0)
      '()
      (cons (car l) (take (- n 1) (cdr l)))
  )
)

(define (my-reverse l)
  (if (null? l)
      '()
      (append (my-reverse (cdr l)) (list (car l)))
  )
)

(define (reverse-iter l)
  (define (helper result left)
    (if (null? left)
        result
        (helper (cons (car left) result) (cdr left))))
  (helper '() l)
)