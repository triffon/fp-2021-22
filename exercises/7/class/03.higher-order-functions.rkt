#lang racket

(define (sum-interval start end)
  (if (> start end)
      0
      (+ start (sum-interval (+ start 1) end)))
)


(define (product-interval start end)
  (if (> start end)
      1
      (* start (product-interval (+ start 1) end)))
)

(define (combine-interval start end op null-value)
  (if (> start end)
      null-value
      (op start (combine-interval (+ start 1) end op null-value)))
)


;(combine-interval start end (lambda (x y) (+ x y)) 0)

; функция, която повдига нещо на трета степен
;(lambda (x) (expt x 3))
; функция, която не променя аргумента си
;(lambda (x) x)
; функция, която ни казва дали число е четно
;(lambda (x) (even? x))
; функция, която ни казва дали число е по-голямо от 100
;(lambda (x) (> x 100))
; функция, която връща по-голямото от две числа
;(lambda (x y) (if (> x y) x y))


(define (any-in-interval? start end p?)
  (cond ((> start end) #f)
        ((p? start) #t)
        (else (any-in-interval? (+ start 1) end p?)))
)

; (compose f g) = f(g(x))
(define (compose f g)
  (lambda (x) (f (g x)))
)

(define (sum-interval2 start end)
  (combine-interval start end + 0)
)

(define (accumulate start end op null-value transform next)
  (if (> start end)
      null-value
      (op (transform start) (accumulate (next start) end op null-value transform next))))

(define (plusone x) (+ 1 x))
(define (id x) x)


(define (sum-cubes-interval start end)
  (define (cube x) (expt x 3))
  (if (> start end)
      0
      (+ (cube start) (sum-cubes-interval (+ start 1) end)))
)

(define (sum-interval-even start end)
  (cond ((> start end) 0)
        ((even? start) (+ start (sum-interval (+ start 2) end)))
        (else (sum-interval (+ start 1) end)))
)


(define (sum-interval-iterative start end)
  (define (sum-interval start end result)
    (if (> start end)
        result
        (sum-interval (+ start 1) end (+ start result))))
  
  (sum-interval start end 0)
)