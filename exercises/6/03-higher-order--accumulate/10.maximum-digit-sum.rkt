#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")


;### Зад 10
; Най-голямата сума на цифрите на цяло число от интервала [a, b].

(define (max x y)
  'тук)

(define (maximum-digit-sum a b)
  'тук)

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
