(require rackunit rackunit/text-ui)

(define (dimensions m)
  (let ((rows (length m))
        (columns (length (car m))))
       (cons rows columns)))

(define dimensions-tests
  (test-suite
    "Tests for dimensions"

    (check-equal? (dimensions '((42))) '(1 . 1))
    (check-equal? (dimensions '((1 2 3) (4 5 6))) '(2 . 3))
    (check-equal? (dimensions '((1 2 3))) '(1 . 3))
    (check-equal? (dimensions '((1) (3) (1) (2))) '(4 . 1))))

(run-tests dimensions-tests)
