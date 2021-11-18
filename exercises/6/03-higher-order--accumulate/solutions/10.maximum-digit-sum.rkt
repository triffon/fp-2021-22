#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")


;### Зад 10
; Най-голямата сума на цифрите на цяло число от интервала [a, b].

(define (max x y)
  (if (> y x)
      y
      x))

(define (digit-sum n)
  (if (< n 10)
      n
      (+ (remainder n 10) (digit-sum (quotient n 10)))))

(define (maximum-digit-sum a b)
  (accumulate max -inf.0 a b digit-sum 1+))

(run-tests
  (test-suite "maximum-digit-sum tests"
    (check = (maximum-digit-sum 0 10)
             9)
    (check = (maximum-digit-sum 0 100) ; числото е 99
             18)
    (check = (maximum-digit-sum 0 260) ; числото е 199
             19)
    (check = (maximum-digit-sum 0 290) ; числото е 289
             19))
  'verbose)
