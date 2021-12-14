(require rackunit rackunit/text-ui)

(define (partial f . args)
  (lambda (x . rest)
    (apply f (append args (list x) rest))))

(define double (partial * 2))
(define mult3 (partial * 1 2 3))

(define partial-tests
  (test-suite
    "Tests for partial"

    (check-equal? (double 21) 42)
    (check-equal? (mult3 4 5) 120)))

(run-tests partial-tests)
