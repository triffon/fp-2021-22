#lang racket
(require rackunit rackunit/text-ui)

;### Задача 12
; Намира броя атоми в дълбокия списък dl.
(define (count-atoms dl)
  'тук)

(run-tests
  (test-suite "count-atoms tests"
    (check-eq? (count-atoms '((1 2 3) (4) ((5 6) ((7))))) 7)
    (check-eq? (count-atoms '()) 0)
    (check-eq? (count-atoms '((((((((100))))))))) 1))
  'verbose)
