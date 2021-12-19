#lang r5rs

(define (add1 x)
  (+ x 1))

(define (abs x)
  (if (> x 0)
      x
      (- 0 x)))

(define (fact x)
  (if (= x 0)
      1
      (* x (fact (- x 1)))))


; zad 0
(define (succ x)
  (+ x 1))

; zad 1
(define (pred-h n x)
  (if (= (succ x) n)
      x
      (pred-h n (succ x))))

(define (pred n)
  (pred-h n 0))

; zad 2
(define (add a b)
  (if (= b 0)
      a
      (add (succ a) (pred b))))

(define (add2-h a b x)
  (if (= x b)
      a
      (add2-h (succ a) b (succ x))))

(define (add2 a b)
  (add2-h a b 0))

; zad 3
(define (multiply a b)
  (if (= b 0)
      0
      (add (multiply a (pred b)) a)))

; zad 5
(define (safe-div-test n y)
  (<= (add y y) n))

(define (safe-div-h n y)
  (if (not (safe-div-test n (succ y)))
      y
      (safe-div-h n (succ y))))

(define (safe-div n)


  (safe-div-h n 0))

; zad 6
(define (fib n)
  (if (or (= n 0) (= n 1))
      1
      (add (fib (pred n)) (fib (pred (pred n))))))

; zad 7

; fast versions of those functions so we can test more easily
(define (addf x y) (+ x y))
(define (predf x) (- x 1))

(define (ack n x y)
  (if (= n 1)
      (addf x y)
      (if (= y 0)
          (if (= n 2)
              0
              1)

          (ack (predf n) x (ack n x (predf y))))))



; ----
