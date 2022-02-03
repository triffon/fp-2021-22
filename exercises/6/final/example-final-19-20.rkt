#lang racket

; Задача 1. База данни се описва с име (низ) и размер в MB (цяло число).
; Сървър за данни се описва с име (низ), капацитет в MB (цяло число)
; и списък от бази данни. Нека е даден списък от сървъри l.
; а) (8 т.) Да се реализира функция maxFree, която намира името на този сървър в l,
; който има най-много свободно място (разликата между капацитета на сървъра
; и сумата на размерите на базите данни).
; б) (12 т.) Да се реализира функция tryRemove, която по име на сървър s проверява
; дали е възможно всички бази от данни от s да се прехвърлят по другите сървъри
; от l (по не повече от една база на сървър) така, че s да бъде изключен.
; Функцията да връща новия списък от сървъри след прехвърлянето, ако е възможно,
; или оригиналния списък l, ако не е възможно.
; Упътване: достатъчно е да се подредят сървърите и базите данни съответно
; по свободно място и размер и да се провери дали има съответствие.
; Ако такова няма, значи разпределение не е възможно.
; в) (Бонус 15 т.) Да се реши б) без ограничението “не повече от една база на сървър”.
; Не е нужно решението да е оптимално по време.

(define l1
  '(("uni-sofia" 240
                 (("fmi" 40)
                  ("fzf" 30)
                  ("fhf" 25)
                  ("rektorat" 100)))
    ("uni-plovdiv" 280
                   (("fmi" 40)
                    ("rektorat" 100)))
    ("uni-ruse" 210
                (("rektorat" 100)))
    ))

(define (foldr1 op l)
  (foldr op (car l) (cdr l)))
(define (sum l)
  (foldr + 0 l))

(define (maximum-on f l)
  (define (fmax x y)
    (if (>= (f x) (f y))
        x
        y))
  (foldr1 fmax l))

(define (free-space s)
  (define capacity (cadr s))
  (define dbs (caddr s))
  (- capacity
     (sum (map cadr dbs))))

(define (utilization s)
  (define capacity (cadr s))
  (define dbs (caddr s))
  (/ capacity
     (sum (map cadr dbs))))

(define (maxFree l)
  (maximum-on free-space l))





(define (largest-db-percent s)
  (define capacity (cadr s))
  (define dbs (caddr s))
  (define largest-db (maximum-on cadr dbs))
  (/ (cadr largest-db)
     capacity

     ))


(define (hasLargestDb l)
  (maximum-on (lambda (s)
                (- 1
                   (largest-db-percent s)))
              l))



(define (sort-on f l)
  (define (insert x sl)
    (cond ((null? sl) (cons x sl))
          ((< (f x) (f (car sl))) (cons x sl))
          (else (cons (car sl)
                      (insert x (cdr sl))))))

  (foldr insert '() l))

(define get-dbs caddr)
(define (zip-with f l1 l2)
  (if (or (null? l1)
          (null? l2))
      l2
      (cons (f (car l1) (car l2))
            (zip-with f (cdr l1) (cdr l2)))))

(define (all p? l)
  (cond ((null? l) #t)
        ((p? (car l)) (all p? (cdr l)))
        (else #f)))


(define (can-fit dbs servers)
  (and (<= (length dbs) (length servers))
       (all (lambda (x) x)
            (zip-with (lambda (db serv)
                        (<= (cadr db) (free-space serv)))
                      dbs
                      servers))))

(define (tryRemove s-name l)
  (define s (assoc s-name l))
  (if (eq? s #f)
      l
      (let ([servers (reverse
                      (sort-on free-space
                               (filter (lambda (x)
                                         (not (equal? (car x)
                                                      s-name)))
                                       l)))]
            [dbs (reverse (sort-on cadr (get-dbs s)))]
            )
        (if (can-fit dbs servers)
            (zip-with (lambda (cand-db cand-s)
                        (define name (car cand-s))
                        (define cap (cadr cand-s))
                        (define cs-dbs (get-dbs cand-s))
                        (list name
                              cap
                              (cons cand-db cs-dbs))
                        )
                      dbs
                      servers)
            l))))




; Задача 3. (15 т.) Разглеждаме дървета от числа с произволен брой наследници на всеки възел,
; с представяне по ваш избор. Числата в дървото могат да се повтарят.
; Да се реализира функция minPredecessor, която по дадено дърво и число x
; намира най-малкото число, в чието поддърво са всички срещания на x.
(define bin-t1
  '(5 ()
      (6 (7 (9 ()
               (10 ()
                   ()))
            (8 ()
               ()))
         ())))
(define t1
  '(1 ()
      ()
      ()
      ()
      ()
      ()
      ()))

(define t2
  '(9 (6)
      (8 ()
         (4 (1 () ())
            (1 () ())
            (1 () ())
            (1 () ()))
         ())
      (7 ())))
(define t3
  '(9 (6 (1))
      (8 (1)
         (4 (1 () ())
            (1 () ())
            (1 () ())
            (1 () ()))
         ())
      (7 ())))
(define t4
  '(15 (1 (9 (6 (1))
             (8 (1)
                (4 (1 () ())
                   (1 () ())
                   (1 () ())
                   (1 () ()))
                ())
             (7 ())))))


(define children cdr)
(define root car)

(define (children-values t)
  (map root
       (filter (lambda (c)
                 (not (null? c)))
               (children t))))

(define (is-candidate x t)
  (not (equal? '()
               (filter (lambda (v)
                         (= x v))
                       (children-values t)))))

;(define (generate x t)
;  (if (null? t)
;      t
;      (let ([r (root t)]
;            [cs (children t)])
;        (map (lambda (c) (generate x c))
;             cs);
;        ))

;TODO: move to if+let
(define (count x t)
  (cond
    ((null? t) 0)
    ((equal? (root t) x)
     (+ 1
        (sum
         (map (lambda (c)
                (count x c))
              (children t)))))
    (else
     (sum
      (map (lambda (c)
             (count x c))
           (children t))))))

(define (safe-car l)
  (if (null? l)
      #f
      (car l)))

(define (any p? l)
  (foldr (lambda (x rec)
           (or (p? x) rec))
         #f
         l))

(define (minPred-not-working x t)
  (if (null? t)
      #f ;'няма-най-малък
      (let* ([r (root t)]
             [cs (children t)]
             [t-count (count x t)]
             [cs-count (map (lambda (c) (count x c)) cs)])
        (if (any (lambda (cc)
                   (>= cc t-count))
                 cs-count)
            (safe-car
             (filter (lambda (y)
                       (not (equal? y #f)))
                     (map (lambda (c)
                            (minPred x c)
                            ) cs)))
            r))))


(define (minPred x t)
  (if (null? t)
      #f
      (let* ([r (root t)]
             [cs (children t)]
             [cand-cs (filter (lambda (c)
                                (not (= 0 (count x c))))
                              cs)]
             [len-c (length cand-cs)])
        (cond
          ((= r x) r)
          ((= len-c 0) #f)
          ((= len-c 1) (minPred x (car cand-cs)))
          (else r)))))


;(define (minPred2 x t)
;  (if (null? t)
;      #f
;      (root (maximum-on (lambda (c) (count x c))
;                        (append (list t)
;                                (children t))))))





; Да се напише функция  pairTree, която преобразува
; двоично  дърво  от числа  в  ново  дърво  със  същата  структура,  в  което
; стойността  във  всеки  възел  е  заменена  с  наредена  двойка,
; представляваща най-малката стойност в лявото поддърво на съответния
; възел (включително и самия възел) и най-голямата стойност в дясното
; поддърво на съответния възел (включително и самия възел).
; Бонус: pairTree да работи за време O(n) в най-лошия случай.
(define (mktree root left right)
  (list root left right))
(define (mkleaf root)
  (mktree root '() '()))

;(define root car)
(define left cadr)
(define right caddr)

(define t6
  (mktree 5 (mktree 3
                    (mktree 1
                            '()
                            (mkleaf 2))
                    (mkleaf 4))
          (mkleaf 6)))

(define (minValue t)
  (if (null? t)
      +inf.0
      (min (root t)
           (min (minValue (left t))
                (minValue (right t))))))
(define (maxValue t)
  (if (null? t)
      -inf.0
      (max (root t)
           (max (maxValue (left t))
                (maxValue (right t))))))

(define (pairTree t)
  (if (null? t)
      t
      (mktree (cons (min (root t)
                         (minValue (left t)))
                    (max (root t)
                         (maxValue (right t))))
              (pairTree (left t))
              (pairTree (right t)))))


(define (minValue2 r t)
  (if (null? t)
      r
      (min (minValue2 (min (root t) r) (left t))
           (minValue2 (min (root t) r) (right t)))))

(define (maxValue2 r t)
  (if (null? t)
      r
      (max (maxValue2 (max (root t) r) (left t))
           (maxValue2 (max (root t) r) (right t)))))

(define (pairTree2 t)
  (if (null? t)
      t
      (mktree (cons (minValue2 (root t) (left t))
                    (maxValue2 (root t) (right t)))
      (pairTree2 (left t))
      (pairTree2 (right t)))))

