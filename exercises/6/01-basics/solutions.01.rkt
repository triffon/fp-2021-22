#lang racket

(define (1+ n) (+ 1 n))
(define (ascii->code char)
  (cond
    ((= char 'A) 65)
    ((= char 'B) 66)
    ((= char 'C) 67)
    ((= char 'D) 68)
    ((= char 'E) 69)
    ; и така нататък...
    (else 'unknown)))

; задачки (`'тук` трябва да попълните):

; зад 1
; № | Преведете следните аритметични изрази на scheme: | пресмятат се до:
;---|--------------------------------------------------|-------------------
; 1 | (10 + 5.16 + 19 + 9.712361) * (20 - (16 - 4))    | 350.97888
; 2 | 1/4 + 2/5 + 3/8 + 6 * (5.1 - 1.6) * (9/3 - 7/4)  | 27.274999999999995
; 3 | 3^(60 ÷ 7) + ((2^10) ÷ 179)                      | 6566
; 4 | (1 - i)^21                                       | колко е?

(define calc1
  (* (+ 10 5.16 19 9.712361) (- 20 (- 16 4))))
(define calc2
  (+ 1/4 2/5 3/8 (* 6 (- 5.1 1.6) (- 9/3 7/4))))
(define calc3
  (+ (expt 3 (quotient 60 7)) (quotient (expt 2 10) 179)))
(define calc4
  (expt (- 1 (sqrt -1)) 21)) ; изчислява се до `-1024 + 1024i`

; зад 2
(define (odd? n) ; нечетно
  (= 1 (remainder n 2)))
(define (even? n) ; четно
  (= 0 (remainder n 2)))

; зад 3
; схемата за оценяване
(define (grade points)
  (cond
    ((< points 60) 2)
    ((< points 100) 3)
    ((< points 140) 4)
    ((< points 180) 5)
    (else 6)))
; бонус точка ако направите оценката да е наредена двойка от число и думичка
(define (grade-pair points)
  (cond
    ((< points 60)  (cons 2 'Слаб))
    ((< points 100) (cons 3 'Среден))
    ((< points 140) (cons 4 'Добър))
    ((< points 180) (cons 5 'Много_добър))
    (else (cons 6 'Отличен))))

; зад 4
; сбор на целите числа в интервала [a, b]
(define (suminterval a b)
  (if (= a b)
      a
      (+ a (suminterval (+ a 1) b))))

; зад 5
(define (slowpow x n)
  (if (= n 0)
      1
      (* x (slowpow x (- n 1)))))
; направете по-бърза имплементация от горната
(define (square x)
  (* x x))
(define (fastpow x n)
  (cond
    ((= n 0) 1)
    ((even? n) (square (fastpow x (quotient n 2))))
    (else (* x (fastpow x (- n 1))))))

; уверете се че и двете функции връщат еднакви отговори
(slowpow 2 10)
(fastpow 2 10)

; сравнете и времената
(time (begin (slowpow 57 100000) (void)))
(time (begin (fastpow 57 100000) (void)))

; псст - Exponentiation by squaring

; зад 6
; синус по формулата на Тейлър около нулата, парциална сума до член n, тъжни спомени
(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(define (partial-sin x n)
  (if (= n 0)
      x
      (+ (/ (* (expt -1 n) (expt x (+ 1 (* 2 n))))
            (fact (+ 1 (* 2 n))))
         (partial-sin x (- n 1)))))

; зад 7 сложна
; колко пъти цифрата d се среща в цялото число n?
(define (digit-occurence d n)
  (if (< n 10)
      (if (= d n) 1 0)
      (+ (if (= d (remainder n 10)) 1 0)
         (digit-occurence d (quotient n 10)))))
