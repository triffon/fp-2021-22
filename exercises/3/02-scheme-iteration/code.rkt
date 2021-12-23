#lang r5rs

; copy-pasta
(define (succ x)
  (+ x 1))

(define (pred n)
  (- n 1))


; zad 1
(define (add a b)
  (if (= b 0)
      a
      (add (succ a) (pred b))))

; zad 2
(define (multiply-iter a b)
  (define (iter a b res)
    (if (= b 0)
        res
        (iter a (pred b) (add res a))))

  (iter a b 0))

; zad 3

(define (fact-iter n)
  (define (iter n res)
    (if (= n 0)
        res
        (iter (pred n) (multiply-iter n res))))

  (iter n 1))

; zad 5

(define (fib-iter n)
  (define (iter n a b)
    (if (or (= n 0) (= n 1))
        a
        (iter (pred n) b (add a b))))

  (iter n 1 1))

; zad 6
(define (count-digits n)
  (define (iter n cnt)
    (if (= n 0)
        cnt
        (iter (quotient n 10) (add 1 cnt))))

  (if (= n 0)
      1
      (iter n 0)))

; zad 7
(define (count-divisors n)
  (define (count-divisors-from m)
    (if (= m 0)
        0
        (if (divides m n)
            (succ (count-divisors-from (pred m)))
                  (count-divisors-from (pred m)))))
  (count-divisors-from n))
        

(define (count-divisors-iter n)
  (define (count-divisors-from m res)
    (if (> m n)
        res
        (if (divides m n)
            (count-divisors-from (succ m) (succ res))
            (count-divisors-from (succ m) res))))
  (count-divisors-from 1 0))

(define (divides m n)
  (= (remainder n m) 0))