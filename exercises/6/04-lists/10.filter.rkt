#lang racket
(require rackunit rackunit/text-ui)

;### Зад 10
; Връща списък от елементите на `l`, за които `pred?` е истина.
(define (filter pred? l)
  'тук)


(run-tests
  (test-suite "filter tests"
    (check-equal? (filter odd? '())
                  '())
    (check-equal? (filter odd? '(1 2 3 4 5 6))
                  '(1 3 5))
    (check-equal? (filter pair? '(1 (2 3) 4 ((5)) 6))
                  '((2 3) ((5))))
    (check-equal? (filter procedure?
                          (list 1 '(2 3) + 4 '((5)) 6 pair? filter))
                  (list + pair? filter)))
  'verbose)
