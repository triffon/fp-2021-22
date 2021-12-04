#lang racket
(define a1
  (list (cons 1 '(2 3 4))
        (cons 1 3)
        (cons 15 2)
        (cons 6 "neshto")))
(define a2
  '((1 2) (2 3) (3 1 4) (4 3 5) (5 5)))

(define (get-value x)
  (cdr x))
(define (assoc k l)
  (cond
    ((null? l) #f)
    ((equal? k (car (car l))) (get-value (car l)))
    (else (assoc k (cdr l)))))

; Напишете функция (index l), която връща асоциативен списък,
; в който всеки елемент x на l е асоцииран с ключ, равен на позицията на x в l.

(define (index L)
  (define (helper i l)
    (if (null? l)
        l
        (cons (cons i (car l)) (helper (+ i 1) (cdr l)))))
  (helper 0 L))

(define (zip l m)
  (if (or (null? l)
          (null? m))
      '()
      (cons (cons (car l) (car m))
            (zip (cdr l) (cdr m)))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (index* l)
  (zip (from-to 0 (length l)) l))

;Напишете функция `(histogram l)`, която
;   връща хистограма на срещанията на всички елементи в `l` под формата на асоциативен списък.
;   Например, `(histogram '(8 7 1 7 8 2 2 8 2 7 8 1))`
;   връща асоциативния списък `'((8 . 4) (7 . 3) (1 . 2) (2 . 3))`.


(define (histogram l)
  (if (null? l)
      '()
      (cons (cons (car l)
                  (length (filter (lambda (x) (equal? x (car l)))
                                  l)))
            (histogram (filter (lambda (x) (not (equal? x (car l))))
                               l)))))
(define (get-key x)
  (car x))

; Напишете функция, която в асоциативен списък изчиства дублирани ключове,
; като запазва само първата стойност.
(define (assoc-unique l)
  (if (null? l)
      '()
      (cons (car l)
            (assoc-unique (filter (lambda (x)
                                    (not (equal? (get-key x)
                                                 (get-key (car l)))))
                                  l)))))

(define g1
  (list
    (cons 1 '(2))
    (cons 2 '(3))
    (cons 3 '(1 4))
    (cons 4 '(3 5))
    (cons 5 '(5))
    (cons 6 '())
    (cons 7 '())))

(define g2
  (list
    (cons 'a '(b))
    (cons 'b '(c))
    (cons 'c '())))
(define g3
  (list
    (cons 1 '())
    (cons 2 '())
    (cons 3 '())
    (cons 4 '())
    (cons 5 '())
    (cons 6 '())
    (cons 7 '())))
(define g4
  (list
    (cons 1 '(2))
    (cons 2 '(3))
    (cons 3 '(4))
    (cons 4 '(5))
    (cons 5 '(5))
    (cons 6 '())
    (cons 7 '())))

; Да се напише функция (predecessors v g),
; която връща списък с всички предшественици
; на върха v в графа g
(define (predecessors v g)
  (map get-key
       (filter (lambda (x)
                 (member v (get-value x)))
               g)))

; Напишете функции (indegree v g) и (outdegree v g),
; които намират съответно полустепените на входа и изхода за връх v от граф g
(define (indegree v g)
  (length (predecessors v g)))

(define (outdegree v g)
  (length (assoc v g)))

(define (keys g)
  (map get-key g))

; Напишете функция (graph-transpose g),
; която връща транспонирания граф на g.
(define (graph-transpose g)
  (define vertexes (keys g))
  (map (lambda (v)
         (cons v (predecessors v g)))
       vertexes))

(define (vertexes g)
  (keys g))

(define (all p? l)
  (foldr (lambda (x rec)
           (and (p? x) rec))
         #t
         l))

; Напишете функция (acyclic? g),
; която проверява дали графът g е ацикличен, тоест няма цикъл.
(define (acyclic? g)
  (define (visit v g visited-path)
    (if (member v visited-path)
        #f
        (all (lambda (u)
               (visit u g (cons v visited-path)))
             (assoc v g))))
  ;(visit (caar g) g '())
  (all (lambda (v)
         (visit v g '()))
       (vertexes g)))














(define (from x)
  (cons x (delay (from (+ 1 x)))))


(define (s-from-to a b)
  (if (> a b)
      '()
      (cons a (delay (s-from-to (+ 1 a) b)))))

(define (s-take n l)
  (if (= n 0)
      '()
      (cons (car l)
            (s-take (- n 1) (force (cdr l))))))
