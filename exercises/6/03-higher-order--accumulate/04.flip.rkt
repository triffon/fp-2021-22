#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 4
; Функцията `flip`, която приема като аргумент функция на два аргумента `f`, и връща `f` с разменени аргументи.
(define (flip f)
  'тук)

(run-tests
  (test-suite "flip tests"
    (check = ((flip expt) 2 5)
             25)
    (check = ((flip remainder) 10 3)
             3))
  'verbose)
