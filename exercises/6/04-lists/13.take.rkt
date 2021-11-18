#lang racket
(require rackunit rackunit/text-ui)

;### Зад 13
; връща списък от първите `n` елемента на `l`.
(define (take n l)
  'тук)


(run-tests
  (test-suite "take tests"
    (check-equal? (take 0 '())
                  '())
    (check-equal? (take 0 '(1 2 3 4))
                  '())
    (check-equal? (take 3 '(2 2 2 2))
                  '(2 2 2))
    (check-equal? (take 3 '(1 (2 3 4) (5 6) ((7))))
                  '(1 (2 3 4) (5 6))))
  'verbose)

