(require rackunit rackunit/text-ui)

(define (zip l1 l2)
  (if (or (null? l1)
          (null? l2))
      '()
      (cons (list (car l1) (car l2))
            (zip (cdr l1) (cdr l2)))))

(define zip-tests
  (test-suite
    "Tests for zip"

    (check-equal? (zip '() '(6 6 6)) '())
    (check-equal? (zip '(1 1 1) '(2 2)) '((1 2) (1 2)))
    (check-equal? (zip '(1 3 5) '(2 4 6)) '((1 2) (3 4) (5 6)))
    (check-equal? (zip '(1 3 5 7 9) '(2 4 6)) '((1 2) (3 4) (5 6)))))

(run-tests zip-tests)
