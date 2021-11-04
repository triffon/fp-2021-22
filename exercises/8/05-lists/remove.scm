(require rackunit rackunit/text-ui)

(define (my-remove l x)
  (cond ((null? l) '())
        ((equal? (car l) x) (cdr l))
        (else (cons (car l)
                    (my-remove (cdr l) x)))))

(define remove-tests
  (test-suite
    "Tests for my-remove"

    (check-equal? (my-remove '(42) 42) '())
    (check-equal? (my-remove '(5 3 5 5) 5) '(3 5 5))
    (check-equal? (my-remove '(1 5 3 5 5) 5) '(1 3 5 5))
    (check-equal? (my-remove '(8 4 92 82 8 13) 82) '(8 4 92 8 13))
    (check-equal? (my-remove '(8 4 82 12 31 133) 133) '(8 4 82 12 31))))

(run-tests remove-tests)
