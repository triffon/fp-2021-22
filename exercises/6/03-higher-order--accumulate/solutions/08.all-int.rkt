#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 8
; Дали **за всяко** цяло число в интервала [a, b] предикатът `pred?` е истина.
(define (all-int? pred? a b)
  (accumulate (lambda (p q) (and p q)) #t a b pred? 1+))

(run-tests
  (test-suite "all-int? tests"
    (check-true (all-int? even? 2 2))
    (check-true (all-int? (lambda (n) (> n 10)) 11 190))
    ; Всеки елемент на празното множество удовлетворява каквото си искаме
    ; и интервалът от 5 до 1 е празното множество, защото 5 > 1.
    ; Тук каквото и да подадем на мястото на `procedure?`, трябва `forall?` да ни връща истина.
    (check-true (all-int? procedure? 5 1))
    (check-false (all-int? odd? 1 10))
    (check-false (all-int? (lambda (n) (> n 10)) 10 190))
    (check-false (all-int? (lambda (n) (< n 10)) 1 10)))
  'verbose)
