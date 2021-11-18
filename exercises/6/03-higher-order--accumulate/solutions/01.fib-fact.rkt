#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 1
; Имплементирайте `fact` и `fib` чрез `accumulate`.
(define (fact n)
  (accumulate * 1 1 n id 1+))

(define (fib n)
  (define half-n (quotient (- n 1) 2))
  (define (term k)
    (/ (fact (- (- n k) 1))
       (* (fact k) (fact (- (- n (* 2 k)) 1)))))
  ; Слагаме нулата като специален случай,
  ; защото формулата не дава верен отговор за нея.
  (if (= n 0)
      0
      (accumulate + 0 0 half-n term 1+)))

(run-tests
  (test-suite "fact-fib tests"
    (test-suite "factorial tests"
      (check = (fact 0)
               1)
      (check = (fact 1)
               1)
      (check = (fact 15)
               1307674368000)
      (check = (fact 5)
               120))
    (test-suite "fibonacci tests"
      (check = (fib 0)
               0)
      (check = (fib 1)
               1)
      (check = (fib 2)
               1)
      (check = (fib 3)
               2)
      (check = (fib 5)
               5)
      (check = (fib 12)
               144)))
  'verbose)
