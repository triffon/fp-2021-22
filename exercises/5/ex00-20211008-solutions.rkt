#lang racket

(+ (/ (+ 3 5) 2)
   (sqrt (- (expt 4 3) (* 7 (expt 2 2)))))

(/ (+ 5 (/ 1 4) (- 2 (- 3 (+ 6 (/ 1 5)))))
   (* 3 (- 6 2) (- 2 7)))

(/ (+ 15 21 (/ 3 15) (- 7 (* 2 2)))
   16)

(define (less-than-5? x)
  (< x 5))

(define (f1 x y)
  (if (< y 0)
      (and (>= y -2) (<= (abs x) 1))
      (<= (sqrt (+ (* x x) (* y y))) 2)))

(define (fact n)
  (if (<= n 1) 1
      (* n (fact (- n 1)))))

(define (fib n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fib (- n 1))
                 (fib (- n 2)))]))


(define (my-if p x y)
  (if p x y))

