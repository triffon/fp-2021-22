#lang racket

(define (any p? l)
  (cond
    ((null? l) #f)
    ((p? (car l)) #t)
    (else (any p? (cdr l)))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (meetTwice? f g a b)
  (define interval (from-to a b))
  (any (lambda (x)
       (any (lambda (y)
              (and (not (= x y))
                   (= (f x) (g x))
                   (= (f y) (g y))))
            ;(member x interval)
            interval
            ))
       interval))

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))
(define (1+ n) (+ 1 n))

(define (meetTwice?** f g a b)
  (accumulate (lambda (p q) (or p q)) #f a b
              (lambda (x)
                (accumulate (lambda (p q) (or p q)) #f a b
                            (lambda (y)
                              (and (not (= x y))
                                   (= (f x) (g x))
                                   (= (f y) (g y))))
                            1+)
              1+)))

(define (meetTwice?* f g a b)
  (define (helper i count)
    (cond ((= count  2) #t)
          ((> i b) #f)
          ((= (f i) (g i))
           (helper (+ i 1) (+ count 1)))
          (else (helper (+ i 1) count))))
  (helper a 0)
)


;(define (meetTwice?* f g a b)
;  (define (helper x
;  (meetTwice?* f g (+ 1 a) b))


;(meetTwice?* (lambda(x)x) (lambda(x) (- x)) -3 1)
;(meetTwice?* (lambda(x)x) sqrt 0 5)
;(meetTwice?* (lambda(x)x) sqrt 5 0)





(define (longest-prefix l)
  (define (helper y l2)
    (cond
      ((null? l2) '())
      ((> (car l2) y) '())
      (else
        (cons (car l2)
              (helper (car l2) (cdr l2))))))

  (if (null? l)
      '()
      (cons (car l)
            (helper (car l) (cdr l)))))

(define (longer l m)
  (if (> (length m) (length l))
      m
      l))

(define (longestDescending l)
  (define (helper longest-list curr-list)
    (define prefix (longest-prefix curr-list))
    (if (null? curr-list)
        longest-list
        (helper (longer longest-list prefix) (cdr curr-list))))
  (helper '() l))

;(longest-prefix '(8 6 4 2 6 7 1))
;(longest-prefix '(1 2 3 4 5))
;(equal? (longest-prefix '(8 6 4 2 6 7 1))
;        '(8 6 4 2))
;(longestDescending '(8 6 4 2 6 7 1))
;(longestDescending '(1 2 3 4 5))





(define (explode-digits n) '?)


(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (quotient n 10)))))

(count-digits 0)
(count-digits 6)
(count-digits 123456)

(count-digits 1234567)

(define (get-digit pos n)
  (if (= pos 0)
      (remainder n 10)
      (get-digit (- pos 1) (quotient n 10))))

(get-digit 0 987651)
(get-digit 3 1234567)

(define (middle-digit n)
  (define c (count-digits n))
  (if (even? c)
      -1
      (get-digit (quotient c 2) n)))

(middle-digit 1234567)
(middle-digit 452)
(middle-digit 4521)




(define (all* p? l)
  (if (null? l)
      #t
      (and (p? (car l))
           (all p? (cdr l)))))

(define (all p? l)
  (foldr (lambda (x rec) (and (p? x) rec))
         #t
         l))

(define (is-em? l ⊕ f)
  (and
    ;∀x∈l f(x)∈l
    (all (lambda (x)
           (member (f x) l))
         l)
    ;∀x,y∈l f(x) ⊕ f(y) = f(x ⊕ y)
    (all (lambda (x)
           (all (lambda (y)
                  (equal? (⊕ (f x) (f y))
                          (f (⊕ x y))))
                l))
         l)))


(is-em? '(0 1 4 6) + (lambda (x) (remainder x 3)))



(define (filter p? l)
  (foldr (lambda (x rec)
           (if (p? x)
               (cons x rec)
               rec))
         '()
         l))


(define (all-int? pred? a b)
  (accumulate (lambda (p q) (and p q)) #t a b pred? 1+))

(define (2+ n) (+ n 2))


(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (id x)
  x)

(define (repeated n f x)
  (if (= n 0)
      x
      (f (repeated (- n 1) f x))))

(define (repeat n f)
  (if (= n 0)
      id
      ;(lambda (x)
      ;  (f ((repeat (- n 1) f) x)))))
      (compose f (repeat (- n 1) f))))


(define (permutable? a b f g)
  (define start
    (if (even? a)
        a
        (+ a 1)))
  (define (func-and p q) (and p q))
  (define (term x)
    ;f(g(...f(g(x))...)) = g(f(...g(f(x))...))
    (equal? ((repeat x (compose f g)) x)
            ((repeat x (compose g f)) x)))

  (accumulate func-and #t start b term 2+)
  )


(permutable? 1 9 (lambda (x) (* x x)) (lambda (x) (* x x x))) ; -> #t

;(repeat n f)
;= lambda x (f (g (f (g (f (g ... (f (g x)))))))))







(define (intersection l m)
  (filter (lambda (x)
            (member x m))
          l))

(intersection '(1 2 3 4 5) '(7 8 4 2 3 5 6 9))

(define (unique l)
  (if (null? l)
      '()
      (cons (car l)
            (unique (filter (lambda (x) (not (equal? x (car l))))
                            (cdr l))))))

(define (union l m)
  (unique (append l m)))

(union '(1 2 3) '(2 3 4 5))

(define (set-minus l m)
  (filter (lambda (x)
            (not (member x m)))
          l))


;Задача 3
; Да се напише функция (numGame l), която проверява дали е вярно,
; че в списъка от числа l всяко число започва с последната цифра на предишното.
;Пример: (numGame '(1234 4325 52 2 2651 10)) → #t
;Пример: (numGame '(1234 12)) → #f

(define (first-digit n)
  (quotient n (expt 10 (- (count-digits n) 1))))

(first-digit 6543321)
(first-digit 0)
(first-digit 3)

(define (last-digit n)
  (remainder n 10))

(define (numGame l)
  (cond
    ((null? l) #t)
    ((null? (cdr l)) #t)
    (else (and (= (last-digit (car l))
                  (first-digit (car (cdr l))))
               (numGame (cdr l))))))

(numGame '(1234 4325 52 2 2651 10))
(numGame '(1234 12))





;Задача 4

;Дефинирайте фунцкия (generate a b l),
;която построява списъка с тези естествени числа в интервала [a,b],
;чиито квадрати са елементи на списъка l.
;Пример: (generate 2 6 '(16 56 9 18 37)) → '(3 4)

(define (generate a b l)
  (filter
    (lambda (x)
      (member (expt x 2) l)
      )
    (from-to a b)))

(define (generate* a b l)
  (define (op x rec)
    (if (member (expt x 2) l)
        (cons x rec)
        rec))
  (accumulate op '() a b id 1+))

(generate* 2 6 '(16 56 9 18 37))

;Задача 5

; Да се напише функция largestInterval,
; която получава като аргументи две едноместни целочислени функции f и g
; и две цели числа a и b.
; Функцията трябва да намира най-големия целочислен подинтервал на [a, b] такъв,
; че двете функции дават еднакви стойности за всяко цяло число в него. Пример:

(define (takeWhile p? l)
  (cond
    ((null? l) '())
    ((p? (car l)) (cons (car l)
                        (takeWhile p? (cdr l))))
    (else '())))

(define (list->interval l)
  (cons (car l)
        (list-ref l (- (length l) 1))))

(define (largestInterval f g a b)
  (define (list-prefix l)
    (takeWhile (lambda (x)
                 (= (f x) (g x)))
               l))

  (define (find-largest largest-list curr-list)
    (define candidate (list-prefix curr-list))
    (if (null? curr-list)
        largest-list
        (find-largest (longer largest-list candidate)
                      (cdr curr-list))))

  (list->interval (find-largest '() (from-to a b))))

(define (largestInterval* f g a b)
  (define (expand y)
    (if (or (> y b)
            (not (= (f y) (g y))))
        (- y 1)
        (expand (1+ y))))

  (define (bigger int1 int2)
    (define k (car int1))
    (define l (cdr int1))
    (define m (car int2))
    (define n (cdr int2))
    (if (> (- n m) (- l k))
        int2
        int1))

  (define (find x largest-interval)
    (define candidate (cons x (expand x)))
    (cond
      ((> x b) largest-interval)
      (else
       (find (1+ x) (bigger largest-interval candidate)))))
  (find a (cons a a))
  )

(largestInterval* (lambda (x) x)
                 (lambda (x) (* x x))
                 0
                 3)
 ; -> (0 . 1)

;(largestInterval (lambda (x) x)
;                 (lambda (x) (* x x))
;                 -inf.0
;                 +inf.0)
