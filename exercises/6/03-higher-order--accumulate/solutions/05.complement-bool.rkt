#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 5
; Приема предикат `pred?` и връща предикат, който отговаря на отрицанието на `pred?`.
(define (complement-bool pred?)
  (lambda (x) (not (pred? x))))

(run-tests
  (test-suite "complement-bool tests"
    (check-false ((complement-bool even?) 2))
    (check-true ((complement-bool even?) 3))
    (check-true ((complement-bool odd?) 20))
    (check-false ((complement-bool odd?) 31)))
  'verbose)
