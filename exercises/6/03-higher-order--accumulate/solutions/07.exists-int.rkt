#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 7
; Дали **има** цяло число в интервала [a, b], за което предикатът `pred?` е истина?
(define (exists-int? pred? a b)
  (accumulate (lambda (p q) (or p q)) #f a b pred? 1+))

(run-tests
  (test-suite "exists-int? tests"
    (check-true (exists-int? even? 1 5))
    (check-true (exists-int? (lambda (n) (> n 10)) 1 11))
    (check-false (exists-int? odd? 2 2))
    (check-false (exists-int? (lambda (n) (> n 10)) 1 10))
    ; Тук интервалът е празното множество, защото 5 > 1.
    ; А празното множество няма елементи, което означава че `exists-int?` винаги връща лъжа за него.
    (check-false (exists-int? number? 5 1)))
  'verbose)
