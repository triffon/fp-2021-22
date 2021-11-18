#lang racket
(require rackunit rackunit/text-ui)

;### Зад 14
; Връща списък от всички елемента на `l` без първите `n`.
(define (drop n l)
  'тук)


(run-tests
  (test-suite "drop tests"
    (check-equal? (drop 0 '())
                  '())
    (check-equal? (drop 0 '(1 2 3 4))
                  '(1 2 3 4))
    (check-equal? (drop 3 '(2 2 2 2))
                  '(2))
    (check-equal? (drop 3 '(1 (2 3 4) (5 6) ((7)) 8))
                  '(((7)) 8)))
  'verbose)
