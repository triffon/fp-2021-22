#lang racket
(require racket/stream)

(define empty-tree '())

(define (make-tree root left right) (list root left right))

(define (make-leaf root) (make-tree root empty-tree empty-tree))

(define root car)
(define left cadr)
(define right caddr)

(define (tree? t)
  (or (null? t)
      (and (list? t)
          (= (length t) 3)
          (tree? (cadr t))
          (tree? (caddr t)))))

(define empty-tree? null?)

; 1. leaves
(define (leaves t)
  (cond
    ((empty-tree? t) '())
    ((and (empty-tree? (left t)) (empty-tree? (right t))) (list (root t)))
    (else (append (leaves (left t)) (leaves (right t))))))

; 2. pre-order
(define (pre-order t)
  (if (empty-tree? t)
      '()
      (append (pre-order (left t))
              (list (root t))
              (pre-order (right t)))))

; 3. bst-member
(define (bst-member? x t)
  (cond ((empty-tree? t) #f)
        ((= x (root t)) #t)
        ((< x (root t)) (bst-member? (left t) x))
        (else (bst-member? (right t) x))))

; 4. bst-insert
(define (bst-insert t x)
  (cond ((empty-tree? t) (make-leaf x))
        ((< x (root t)) (make-tree (root t) (bst-insert (left t) x) (right t)))
        (else (make-tree (root t)
                        (left t)
                        (insert (right t) x)))))

; 5. flip
(define (flip t)
  (if (empty-tree? t)
    '()
    (make-tree (root t) (flip (right t)) (flip (left t)))))

; Streams
; Сравнение на списъци с потоци

; delay
; force


; empty list: '() -> empty stream: '()
; cons -> stream-cons
; car -> stream-first
; cdr -> stream-rest
; list -> stream
; list-ref -> stream-ref

; 6. В интервал:
(define (stream-from-interval start end)
  (if (= start end)
      (stream end)
      (stream-cons start (stream-from-interval (+ start 1) end))))

; 7. stream-to-list
(define (stream-to-list stream)
  (if (stream-empty? stream)
      '()
      (cons (stream-first stream)
            (stream-to-list
              (stream-rest stream)))))

; 8. stream-from-list
(define (stream-from-list l)
  (if (null? l)
      empty-stream
      (stream-cons (car l)
                  (stream-from-list (cdr l)))))

; 9. поток от единици
(define ones
  (stream-cons 1 ones))

(stream-to-list (stream-take ones 3))

; 10. n-stream
(define (n-stream start)
  (stream-cons start
              (n-stream (+ start 1))))

; 11. 
(define (my-stream-take stream n)
  (if (= n 0)
      empty-stream
      (stream-cons (stream-first stream)
                   (my-stream-take (stream-rest stream)
                                (- n 1)))))


; 13. Фибоначи
  (define (fibonacci)
    (define (helper a b)
      (stream-cons a
                  (helper b (+ a b))))
    (helper 1 1))


;14. repeat-list
(define (repeat-list l)
  (define (helper current-list)
    (if (null? current-list)
        (helper l)
        (stream-cons (car current-list)
                     (helper (cdr current-list)))))
  (helper l))