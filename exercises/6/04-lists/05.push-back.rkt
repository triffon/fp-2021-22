#lang racket
(require rackunit rackunit/text-ui)

;### Зад 5
; Слага `x` накрая на `l` (връщайки нов списък).
(define (push-back x l)
  'тук)


(define l1 '(1 2 3 4 5 6 7 8))
(define l2 '(0 (12 13) (21 22)))

(run-tests
  (test-suite "push-back tests"
    (check-equal? (push-back 5 '(1 2))
                  '(1 2 5))
    (check-equal? (push-back 5 '())
                  '(5))
    (check-equal? (push-back '() '())
                  '(())))
  'verbose)
