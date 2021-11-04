(require rackunit rackunit/text-ui)

(define (my-filter l p)
  (if (null? l)
      '()
      (if (p (car l))
          (cons (car l) (my-filter (cdr l) p))
          (my-filter (cdr l) p))))

(define filter-tests
  (test-suite
    "Tests for filter"

    (check-equal? (my-filter '() even?) '())
    (check-equal? (my-filter '(42) even?) '(42))
    (check-equal? (my-filter '(42) odd?) '())
    (check-equal? (my-filter '(1 2 3 4) (lambda (x) (> x 0))) '(1 2 3 4))
    (check-equal? (my-filter '(1 2 3 4) (lambda (x) (< x 0))) '())
    (check-equal? (my-filter '(1 2 -42 3 4) (lambda (x) (< x 0))) '(-42))
    (check-equal? (my-filter '(8 4 92 82 8 13) even?) '(8 4 92 82 8))
    (check-equal? (my-filter '(8 4 92 82 8 13) odd?) '(13))))

(run-tests filter-tests)
