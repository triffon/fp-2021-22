#lang racket

; 1. За дадено естествено число n намира n+1.
(define (succ x) (+ x 1))

; 2. За дадено естествено число n намира n-1.
(define (pred x) (- x 1))

; 3. За дадено число n, връща n/2 ако n е четно, и n в противен случай.
(define (safe-div x)
  (if (even? x)
    (/ x 2)
    x))

; 4. За дадено x проверява дали е корен на (3*x^2 - 2*x - 1).
; Полинома не се променя.
; Корени: -1/3, 1
(define (is-root? x)
    (zero? (+ -1
              (* -2 x)
              (* 3 (expt x 2)))))

; 5. Намира n!.
(define (factorial n)
  (if (= n 0) 1 (* n (factorial (- n 1)))))

; 6. Намира n-тото число на Фибоначи.
(define (fibonacci n)
  (if (< n 2)
    n
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

; 7. Намира сумата на 2 естествени числа, използвайте succ и pred.
(define (add x y)
  (if (= x 0)
    y
    (succ (add (pred x) y))))

; 8. намира произведението на 2 естествени числа.
; Използвайте add и pred.
(define (multiply x y)
  (cond [(= 0 x) 0]
        [(= 1 x) y]
        [else (add y(multiply (pred x) y))]))

; 9. Намира броя на цифрите на дадено естествено число n.
; Реализирайте я рекурсивно.
(define (count-digits n)
  (if (< n 10)
    1
    (+ 1 (count-digits (quotient n 10)))))

; 10. За дадени цяло число x и естествено число n връща x^n.
(define (pow x n)
  (if (zero? n)
    1
    (* x (pow x (- n 1)))))

; 11. За дадени числа a и b намира сумата на целите числа в интервала [a,b].
; Нека a < b.
(define (interval-sum a b)
  (if (= a b)
    b
    (+ a (interval-sum (+ a 1) b))))
