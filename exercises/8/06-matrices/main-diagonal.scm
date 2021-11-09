(require rackunit rackunit/text-ui)



(define main-diagonal-tests
  (test-suite
    "Tests for main-diagonal"

    (check-equal? (main-diagonal '((42))) '(42))
    (check-equal? (main-diagonal '((1 2 3) (4 5 6) (7 8 9))) '(1 5 9))
    (check-equal? (main-diagonal '((1 2 3 10) (4 5 6 20) (7 8 9 30))) '(1 5 9))
    (check-equal? (main-diagonal '((1 2 3) (4 5 6) (7 8 9) (10 11 12))) '(1 5 9))
    (check-equal? (main-diagonal '((1) (2) (3) (4) (5))) '(1))))

(run-tests main-diagonal-tests)
