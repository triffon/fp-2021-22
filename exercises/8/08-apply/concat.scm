(require rackunit rackunit/text-ui)

(define (concat x . l)
  (if (null? l)
      x
      (append x (apply concat l))))

(define concat-tests
  (test-suite
    "Tests for concat"

    (check-equal? (concat '(1) '(13 12) '() '(42 17 9))
                  '(1 13 12 42 17 9))))

(run-tests concat-tests)
