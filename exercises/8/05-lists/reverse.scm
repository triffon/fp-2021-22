(require rackunit rackunit/text-ui)

(define (reverse l)
  (define (loop original reversed)
    (if (null? original)
        reversed
        (loop (cdr original)
              (cons (car original)
                    reversed))))

  (loop l '()))

(define reverse-tests
  (test-suite
    "Tests for reverse"

    (check-equal? (reverse '()) '())
    (check-equal? (reverse '(42)) '(42))
    (check-equal? (reverse '(1 2)) '(2 1))
    (check-equal? (reverse '(1 2 3 4 5 6)) '(6 5 4 3 2 1))
    (check-equal? (reverse '(4 3 3 2 5 2)) '(2 5 2 3 3 4))
    (check-equal? (reverse '(1 2 3 2 1)) '(1 2 3 2 1))))

(run-tests reverse-tests)
