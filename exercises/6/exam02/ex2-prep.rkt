#lang racket
;Задача 3. (8 т.) Покупка се означава с наредена тройка от име на магазин (низ),
; категория (низ) и цена (дробно число).
;Да се реализира функция, която по даден списък от покупки връща списък от тройки,
; OK    съдържащи категория,
; OK    обща цена на покупките в тази категория
; OK    и името на магазина, в който общата цена на покупките в тази категория
;       е максимална.
; OK    Всяка категория да се среща в точно една тройка от резултата.

(define pur1 (list "Gosho's store" "Clothing" 6.5))
(define pur2 (list "Gosho's store" "Books" 10.7))
(define pur3 (list "Gosho's store" "Toys" 63))
(define pur4 (list "Pesho's store" "Toys" 60.5))
(define pur5 (list "Pesho's store" "Books" 100.7))
(define pur6 (list "Pesho's store" "Books" 100.7))

(define l1 (list pur1 pur2 pur3 pur4 pur5 pur6))

(define (unique l)
  (if (null? l)
      l
      (cons (car l)
            (filter (lambda (x) (not (equal? x (car l))))
                    (unique (cdr l))))))


(define get-store car)
(define get-category cadr)
(define get-price caddr)

(define (categories ps)
  (unique (map (lambda (x) (get-category x))
               ps)))

(define (stores ps)
  (unique (map (lambda (x) (get-store x))
               ps)))

(define (sum l) (foldr + 0 l))

(define (sum-price cat ps)
  (sum (map get-price
            (filter (lambda (pur)
                      (equal? (get-category pur)
                              cat))
                    ps))))

(define (maximum l)
  (if (null? (cdr l))
      (car l)
      (max (car l)
           (maximum (cdr l)))))
;(define (maximum l)
;  (foldr1 max l))
(define (foldr1 op l)
  (if (null? (cdr l))
      (car l)
      (op (car l)
          (foldr1 op (cdr l)))))


(define (maximumOn f l)
  (define (maxOnF x y)
    (if (>= (f x) (f y))
        x
        y))
  (foldr1 maxOnF l))

; и името на магазина, в който общата цена на покупките в тази категория
; е максимална.
(define (max-store cat ps)
  (maximumOn (lambda (store)
               (sum (map get-price
                         (filter (lambda (pur)
                                   (and (equal? (get-category pur)
                                                cat)
                                        (equal? (get-store pur)
                                                store)))
                                 ps))))
             (stores ps)))

(define (summary purchases) ;-> (Category, Price, StoreName)
  (map (lambda (cat)
         (list cat (sum-price cat purchases) (max-store cat purchases)))
       (categories purchases)))





;; ПОТОЦИ
(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?)

(define s1 (cons-stream 1 (cons-stream 2 (cons-stream 3 '()))))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t)
     (cons h (delay t)))))

(define ones
  (cons-stream 1 ones))

(define (from x)
  ;(cons x (delay (from (+ 1 x)))))
  (cons-stream x (from (+ 1 x))))

(define (s-from-to a b)
  (if (> a b)
      '()
      (cons-stream a (s-from-to (+ 1 a) b))))

(define (s-take n l)
  (if (= n 0)
      '()
      (cons (head l)
            (s-take (- n 1) (tail l)))))

(define nats (from 0))
(define (map-stream f s)
  (if (empty-stream? s)
      s
      (cons-stream (f (head s))
                   (map-stream f (tail s)))))

(define (1+ n) (+ n 1))

;(define (zip-streams-with f s1 s2)
;  (cons-stream (f (head s1)
;                  (head s2))
;               (zip-streams-with f (tail s1) (tail s2))))


(define (filter-stream p? s)
  (if (p? (head s))
      (cons-stream (head s)
                   (filter-stream p? (tail s)))
      (filter-stream p? (tail s))))


(define (drop n l)
  (cond
    ((null? l) l)
    ((= n 0) l)
    (else
     (drop (- n 1) (cdr l)))))





(define stern-example
  '((1 1)
    (1 2 1)
    (1 3 2 3 1)
    (1 4 3 5 2 5 3 4 1)
    (1 5 4 7 3 8 5 7 2 7 5 8 3 7 4 5 1)
    ))

;(define (stream-concat s)
;     (foldr (lambda (x rec) (cons-stream x (force rec)))
;            (delay (stream-concat (tail s)))
;            (head s)))


;Задача 2. (8 т.) Разглеждаме безкрайна редица ls от списъци от числа,
;която започва със списъка [1, 1],
; а всеки следващ списък се получава от предишния,
; като между всеки два елемента се вмъкне сумата им.

;Да се реализира функцията?? stern, която намира безкраен поток,
;получен от конкатенацията на списъците в ls с пропуснат последен
;елемент (който е винаги със стойност 1).
;Пример: stern [1,1] → [ 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, ...

;(define (sum l) (foldr + 0 l))

(define (init l)
  (if (null? (cdr l))
      '()
      (cons (car l) (init (cdr l)))))

(define (between-every2 l)
  (if (< (length l) 2)
      l
      (let ((s (sum (s-take 2 l))))
        (append (list (car l) s) ; (list 1 3); (list 2 3)
                (between-every2 (cdr l))))))
(define (generate l)
  (cons-stream (cdr l) ; може и с (init l)
               (generate (between-every2 l))))

(define (concat l) (apply append l))

(define-syntax append-stream
  (syntax-rules ()
    ((append-stream h t)
     (append h (delay t)))))

(define (s-concat sl)
  (append-stream (head sl)
                 (s-concat (tail sl))))

(define stern
  (cons-stream 1
               (s-concat (generate '(1 1)))))









(define g1
  '((1 2 4)
    (2 4)
    (3 1)
    (4)
    ))
(define (children v g)
  (cdr (assoc v g)))

; Разглеждаме ациклични графи с представяне по ваш избор.
; “Семейство” наричаме множество от възли F такова,
; OK     че за всеки възел u ∈ F е вярно, че
;     1. във F са всичките му деца
;     и 2. нито един негов родител
; или
;     1. всичките му родители
;     и 2. нито едно негово дете.

;а) (6 т.) Да се реализира функция isFamily,
;която проверява дали дадено множество от възли е семейство в даден граф;

(define (all? p? l)
  (if (null? l)
      #t
      (and (p? (car l))
           (all? p? (cdr l)))))

(define (parents v g)
  (map car
       (filter (lambda (pair)
                 (define p-children (cdr pair))
                 (member v p-children))
               g)))

; all-paths from u to v

(define (isFamily l g)
  (all? (lambda (x)
          (or (and (all? (lambda (c)
                           (member c l))
                         (children x g))
                   (all? (lambda (p)
                           (not (member p l)))
                         (parents x g)))
              (and (all? (lambda (c)
                           (member c l))
                         (parents x g))
                   (all? (lambda (p)
                           (not (member p l)))
                         (children x g)))))
        l))

(require rackunit rackunit/text-ui)

(define gg?g '((1 2 3 4) (2 5) (3 6) (4 7) (5 8) (6 8) (7 8) (8)))

(define ts '(() (8) (5 6 7 8) (4 7) (3 6) (3 4 6 7) (2 5) (2 4 5 7) (2 3 5 6)
                (2 3 4 5 6 7) (1) (1 8) (1 5 6 7 8) (1 2 3 4) (1 2 3 4 8)))
(define fs '(
             (7) (7 8) (6) (6 8) (6 7) (6 7 8) (5) (5 8) (5 7) (5 7 8) (5 6) (5 6 8) (5 6 7)
                 (4) (4 8) (4 7 8) (4 6) (4 6 8) (4 6 7) (4 6 7 8) (4 5) (4 5 8) (4 5 7)
                 (4 5 7 8) (4 5 6) (4 5 6 8) (4 5 6 7) (4 5 6 7 8) (3) (3 8) (3 7) (3 7 8)
                 (3 6 8) (3 6 7) (3 6 7 8) (3 5) (3 5 8) (3 5 7) (3 5 7 8) (3 5 6) (3 5 6 8)
                 (3 5 6 7) (3 5 6 7 8) (3 4) (3 4 8) (3 4 7) (3 4 7 8) (3 4 6) (3 4 6 8)
                 (3 4 6 7 8) (3 4 5) (3 4 5 8) (3 4 5 7) (3 4 5 7 8) (3 4 5 6) (3 4 5 6 8)
                 (3 4 5 6 7) (3 4 5 6 7 8) (2) (2 8) (2 7) (2 7 8) (2 6) (2 6 8) (2 6 7)
                 (2 6 7 8) (2 5 8) (2 5 7) (2 5 7 8) (2 5 6) (2 5 6 8) (2 5 6 7) (2 5 6 7 8)
                 (2 4) (2 4 8) (2 4 7) (2 4 7 8) (2 4 6) (2 4 6 8) (2 4 6 7) (2 4 6 7 8)
                 (2 4 5) (2 4 5 8) (2 4 5 7 8) (2 4 5 6) (2 4 5 6 8) (2 4 5 6 7) (2 4 5 6 7 8)
                 (2 3) (2 3 8) (2 3 7) (2 3 7 8) (2 3 6) (2 3 6 8) (2 3 6 7) (2 3 6 7 8)
                 (2 3 5) (2 3 5 8) (2 3 5 7) (2 3 5 7 8) (2 3 5 6 8) (2 3 5 6 7) (2 3 5 6 7 8)
                 (2 3 4) (2 3 4 8) (2 3 4 7) (2 3 4 7 8) (2 3 4 6) (2 3 4 6 8) (2 3 4 6 7)
                 (2 3 4 6 7 8) (2 3 4 5) (2 3 4 5 8) (2 3 4 5 7) (2 3 4 5 7 8) (2 3 4 5 6)
                 (2 3 4 5 6 8) (2 3 4 5 6 7 8) (1 7) (1 7 8) (1 6) (1 6 8) (1 6 7) (1 6 7 8)
                 (1 5) (1 5 8) (1 5 7) (1 5 7 8) (1 5 6) (1 5 6 8) (1 5 6 7) (1 4) (1 4 8)
                 (1 4 7) (1 4 7 8) (1 4 6) (1 4 6 8) (1 4 6 7) (1 4 6 7 8) (1 4 5) (1 4 5 8)
                 (1 4 5 7) (1 4 5 7 8) (1 4 5 6) (1 4 5 6 8) (1 4 5 6 7) (1 4 5 6 7 8) (1 3)
                 (1 3 8) (1 3 7) (1 3 7 8) (1 3 6) (1 3 6 8) (1 3 6 7) (1 3 6 7 8) (1 3 5)
                 (1 3 5 8) (1 3 5 7) (1 3 5 7 8) (1 3 5 6) (1 3 5 6 8) (1 3 5 6 7) (1 3 5 6 7 8)
                 (1 3 4) (1 3 4 8) (1 3 4 7) (1 3 4 7 8) (1 3 4 6) (1 3 4 6 8) (1 3 4 6 7)
                 (1 3 4 6 7 8) (1 3 4 5) (1 3 4 5 8) (1 3 4 5 7) (1 3 4 5 7 8) (1 3 4 5 6)
                 (1 3 4 5 6 8) (1 3 4 5 6 7) (1 3 4 5 6 7 8) (1 2) (1 2 8) (1 2 7) (1 2 7 8)
                 (1 2 6) (1 2 6 8) (1 2 6 7) (1 2 6 7 8) (1 2 5) (1 2 5 8) (1 2 5 7) (1 2 5 7 8)
                 (1 2 5 6) (1 2 5 6 8) (1 2 5 6 7) (1 2 5 6 7 8) (1 2 4) (1 2 4 8) (1 2 4 7)
                 (1 2 4 7 8) (1 2 4 6) (1 2 4 6 8) (1 2 4 6 7) (1 2 4 6 7 8) (1 2 4 5)
                 (1 2 4 5 8) (1 2 4 5 7) (1 2 4 5 7 8) (1 2 4 5 6) (1 2 4 5 6 8) (1 2 4 5 6 7)
                 (1 2 4 5 6 7 8) (1 2 3) (1 2 3 8) (1 2 3 7) (1 2 3 7 8) (1 2 3 6) (1 2 3 6 8)
                 (1 2 3 6 7) (1 2 3 6 7 8) (1 2 3 5) (1 2 3 5 8) (1 2 3 5 7) (1 2 3 5 7 8)
                 (1 2 3 5 6) (1 2 3 5 6 8) (1 2 3 5 6 7) (1 2 3 5 6 7 8) (1 2 3 4 7)
                 (1 2 3 4 7 8) (1 2 3 4 6) (1 2 3 4 6 8) (1 2 3 4 6 7) (1 2 3 4 6 7 8)
                 (1 2 3 4 5) (1 2 3 4 5 8) (1 2 3 4 5 7) (1 2 3 4 5 7 8) (1 2 3 4 5 6)
                 (1 2 3 4 5 6 8) (1 2 3 4 5 6 7) (1 2 3 4 5 6 7 8)))

(define (all v)
  (define (&& x y) (and x y))
  (define (veq x) (eq? x v))
  (lambda (xs)
    (foldr && #t (map veq xs))))

(run-tests (test-suite "neshto"
                       (check-pred (all #t) (map (lambda (x) (isFamily x gg?g)) ts))
                       (check-pred (all #f) (map (lambda (x) (isFamily x gg?g)) fs))))



(define t1
  '(5 (6 (8 () ())
         ())
      (7 (9 () ())
         ())))

(define tnull? null?)
(define root car)
(define left cadr)
(define right caddr)

(define (collect t)
  (if (tnull? t)
      '()
      (append (list (root t))
              (collect (left t))
              (collect (right t)))))

(define (cons#f x l)
  (if x
      (cons x l)
      l))
  

; Да се напише функция findGrandsons t,
; която за дадено двоично дърво от цели числа t намира списък от всички числа,
; които се делят на дядо си, но не и на баща си
(define (helper t father grandpa)
  (define (check v)
    (and father
         grandpa
         (not (= 0 (remainder v father)))
         (= 0 (remainder v grandpa))))
  
  (if (tnull? t)
      '()
      (append  (if (check (root t))
                   (list (root t))
                   '())
               (helper (left t) (root t) father)
               (helper (right t) (root t) father))))


(define (findGrandsons t)
  (helper t #f #f))

(define t2
  '(2 (3 (4 (4 () ()) ())
         (5 () ()))
      (5 (8 () ())
         ())))



; sumLast 3 5 → [3, 3, 6, 12, 24, 48, 93, 183, ... ]
;Задача 2 (8 т.) [Scheme/Haskell] Да се напише функция sumLast, която
;приема две положителни естествени числа k и n и генерира безкрайния
;поток, в който първото число е k, а всяко следващо число е равно на
;сумата от предходните n числа в потока.
;Пример: sumLast 3 5 → [3, 3, 6, 12, 24, 48, 93, 183, ... ]

(define sum-example
  '(3
    3
    6
    12
    24
    48
    93
    183))

(define (generate2 memory)
  (define new-element (sum memory))
  (cons-stream new-element
               (generate2 (append 
                           (cdr memory)
                           (list new-element)))))

(define (gen-start n memory)
  (define new-element (sum memory))
  (if (= n 0)
      (generate2 memory)
      (cons-stream new-element
                   (gen-start (- n 1) (append memory
                                              (list new-element))))))
      
  
(define (sumLast k n)
  (cons k (gen-start n (list k))))
  



;;; намира списък от всички числа, к. са равни на сумата от внуците си

(define (grandchildren t)
  (level 2 t))

(define (level i t)
  (if (tnull? t)
      '()
      (append (if (= i 0)
                  (list (root t))
                  '())
              (level (- i 1) (left t))
              (level (- i 1) (right t)))))

(define (check-gp t)
  (= (root t)
     (sum (grandchildren t))))
  
(define (findGrandpas t)
  (if (tnull? t)
      '()
      (append (if (check-gp t)
                  (list (root t))
                  '())
              (findGrandpas (left t))
              (findGrandpas (right t)))))

(define t3
  '(17 (3 (4 (400 (4 () ()) ()) ())
          (5 () ()))
       (5 (8 () ())
          ())))

; всички пътища от u до v във графа g
; dfsAllPaths :: Vertex -> Vertex -> Graph -> [Path]
(define (dfs-all-paths u v g)
  (define (dfs-visit path)
    (define current (car path))
    (if (= current v)
        (list (reverse path))

        (concat (map (lambda (c)
               (dfs-visit (cons c path)))
             (children current g)))))
  (dfs-visit (list u)))

(define g2
  '((0 1 2)
    (1 2 3)
    (2 3)
    (3 4)
    (4 5)
    (5)
    ))