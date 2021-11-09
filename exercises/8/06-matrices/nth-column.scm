(require rackunit rackunit/text-ui)



(define nth-column-tests
  (test-suite
    "Tests for nth-column"

    (check-equal? (nth-column '((1) (4) (7)) 1) '(1 4 7))
    (check-equal? (nth-column '((1 2 3) (4 5 6) (7 8 9)) 2) '(2 5 8))
    (check-equal? (nth-column '((1 2) (4 3) (7 4) (5 6) (10 9)) 2) '(2 3 4 6 9))))

(run-tests nth-column-tests)
