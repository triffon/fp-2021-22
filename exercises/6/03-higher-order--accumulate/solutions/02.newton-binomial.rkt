#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

;### Зад 2
; Нютонов бином чрез `accumulate`.
; https://en.wikipedia.org/wiki/Binomial_theorem
(define (newton-binomial x y n)
  (define (term k)
    (* (/ (fact n) (* (fact k) (fact (- n k))))
       (expt x k)
       (expt y (- n k))))
  (accumulate + 0 0 n term 1+))

(run-tests
  (test-suite "newton-binomial tests"
    (check-= (newton-binomial 1 1 10)
             1024
             0.0001))
  'verbose)
