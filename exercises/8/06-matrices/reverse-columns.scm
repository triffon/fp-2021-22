(require rackunit rackunit/text-ui)

(define (reverse-columns m)
  (map reverse m))

(define reverse-columns-tests
  (test-suite
    "Tests for reverse-columns"


    (check-equal? (reverse-columns '((1) (2)))
                                   '((1) (2)))
    (check-equal? (reverse-columns '((1 2 3) (4 5 6) (7 8 9)))
                                   '((3 2 1) (6 5 4) (9 8 7)))
    (check-equal? (reverse-columns '((1 1 1 1) (0 1 0 1) (7 8 9 10) (0 1 2 3)))
                                   '((1 1 1 1) (1 0 1 0) (10 9 8 7) (3 2 1 0)))))

(run-tests reverse-columns-tests)
