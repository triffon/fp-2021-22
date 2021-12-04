#lang racket
(define (atom? x)
  (not (list? x)))

(define (list? x)
  (or (null? x)
      (and (pair? x)
           (list? (cdr x)))))

(define (atom?2 x)
  (and (not (null? x))
       (not (pair? x))))

;(define (add . l)
;  (foldr + 0 l))

(define (add2 x . l)
  (if (null? l)
      x
      (+ x (apply add2 l))))

;((lambda x (+ 2 x)) 10 6 5 4 'oshte)









;;; абстракция за матрица
(define (get-first-row m)
  (car m))
(define (remove-first-row m)
  (cdr m))
(define (empty-matrix? m)
  (null? m))
(define empty-matrix '())

(define (get-first-column m)
  (map car m))
(define (remove-first-column m)
  (map cdr m))

(define (all p? l)
  (define (my-and . l)
    (if (null? l)
        #t
        (and (car l) (apply my-and (cdr l)))))
  (apply my-and (map p? l)))


(define (matrix? x)
  (and (list? x)
       (all list? x)
       (all (lambda (row)
              (all number? row))
            x)
       (all (lambda (row)
              (= (length row)
                 (length (car x))))
            x)))

;(define (transpose m)
;  )

;;; задачи
(define (get-row n m)
  (list-ref m n))

(define (get-row* n m)
  (cond
    ((empty-matrix? m) #f)
    ((= n 0) (get-first-row m))
    (else (get-row* (- n 1) (remove-first-row m)))))

;(get-first-row example-matrix1)


(define (get-column n m)
  (cond
    ((empty-matrix? m) #f); (error "матрицата е изчерпана"))
    ((= n 0) (get-first-column m))
    (else (get-column (- n 1)
                      (remove-first-column m)))))



(define (transpose m)
  (if (null? (get-first-row m))
      empty-matrix
      (cons (get-first-column m)
            (transpose (remove-first-column m)))))



(define empty-tree '())
(define (make-tree root left right)
  (list root left right))

(define (make-tree3 root first second third)
  (list root first second third))
(define (make-treen root children)
  (list root children))

(define t1
  (make-tree 1
             (make-tree 2 empty-tree empty-tree)
             (make-tree 3
                        (make-tree 4 empty-tree empty-tree)
                        (make-tree 5 empty-tree empty-tree))))

(define (root-tree tree)
  (car tree))
(define (left-tree tree)
  (cadr tree))
(define (right-tree tree)
  (caddr tree))

(define (empty-tree? tree)
  (equal? empty-tree tree))
;(null? tree))

;(define (leaf? tree)
;  (and (not (empty-tree? tree))
;       (empty-tree? (left-tree tree))
;       (empty-tree? (right-tree tree))))

(define (tree? x)
  (or (empty-tree? x)
      (and (list? x)
           (= (length x) 3)
           (tree? (left-tree x))
           (tree? (right-tree x)))))


(define (collect-in-order t)
  (if (empty-tree? t)
      '()

      (append (collect-in-order (left-tree t))
              (list (root-tree t))
              (collect-in-order (right-tree t)))))


(define (collect-pre-order t)
  (if (empty-tree? t)
      '()
      (append (list (root-tree t))
              (collect-pre-order (left-tree t))
              (collect-pre-order (right-tree t)))))
      ;(cons (root-tree t)
      ;      (append (collect-pre-order (left-tree t))
      ;              (collect-pre-order (right-tree t))))))

(define (collect-post-order t)
  (if (empty-tree? t)
      '()

      (append (collect-post-order (left-tree t))
              (collect-post-order (right-tree t))
              (list (root-tree t)))))


;(define t2
;  (make-tree ))

(define t2
  '(5
    (2 (-4 () ())
       (3 () ()))
    (19 (9 () ())
        (21 (19 () ())
            (25 () ())))))
(define t3
  '(5
    (2 (-4 () ())
       (3 () (800 () ())))
    (19 (9 () ())
        (21 (19 () ())
            (25 () ())))))


(define (square x) (* x x))


(define (map-tree f t)
  (if (empty-tree? t)
      t
      (make-tree (f (root-tree t))
                 (map-tree f (left-tree t))
                 (map-tree f (right-tree t)))))
(define (leaf? t)
  (and (tree? t)
       (not (empty-tree? t))
       (empty? (left-tree t))
       (empty? (right-tree t))))

; heaight-vertex
; heaight-edge
(define (height t)
  (if (or (empty-tree? t)
          (leaf? t))
      0
      (+ 1
         (max (height (left-tree t))
              (height (right-tree t))))))

(define (level n t)
  (cond
    ((empty-tree? t) t)
    ((= n 0) (list (root-tree t)))
    (else
     (append (level (- n 1) (left-tree t))
             (level (- n 1) (right-tree t))))))

(define (count-leaves t)
  (cond
    ((empty-tree? t) 0)
    ((leaf? t) 1)
    (else (+ (count-leaves (left-tree t))
             (count-leaves (right-tree t))))))

(define (remove-leaves t)
  (cond
    ((empty-tree? t) t)
    ((leaf? t) empty-tree)
    (else (make-tree
           (root-tree t)
           (remove-leaves (left-tree t))
           (remove-leaves (right-tree t))))))

(define em1
  '((1 2 3 4)
    (5 6 7 8)
    (1 2 3 8)))

(define em3
  '((7 8)
    (9 10)))
(define em2
  '((1 2 3)
    (4 5 6)))
(define em4
  '((1 2 3)
    (4 5 6)))
(define em5
  '((10 11)
    (20 21)
    (30 31)))

(define (v-mult v1 v2)
  (if (or (null? v1)
          (null? v2))
      '()
      (cons (* (car v1) (car v2))
            (v-mult (cdr v1) (cdr v2)))))

(define (sum l)
  (foldr + 0 l))

(define (multiply m1 m2)
  (map (lambda (row1)
         (map (lambda (col2)
                (sum (v-mult row1 col2)))
              (transpose m2)))
       m1))

