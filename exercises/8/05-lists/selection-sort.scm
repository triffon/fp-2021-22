(require rackunit rackunit/text-ui)

(define (remove-one l x)
  (cond ((null? l) '())
        ((equal? (car l) x) (cdr l))
        (else (cons (car l)
                    (remove-one (cdr l) x)))))

(define (minimum l)
  (foldl min (car l) (cdr l)))

(define (selection-sort l)
  (if (null? l)
      '()
      (let ((min-element (minimum l)))
           (cons min-element
                 (selection-sort (remove-one l min-element))))))

(define selection-sort-tests
  (test-suite
    "Tests for selection-sort"

    (check-equal? (selection-sort '(42)) '(42))
    (check-equal? (selection-sort '(6 6 6)) '(6 6 6))
    (check-equal? (selection-sort '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(6 5 4 3 2 1)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(3 1 4 6 2 5)) '(1 2 3 4 5 6))
    (check-equal? (selection-sort '(5 2 5 1 5 2 3)) '(1 2 2 3 5 5 5))))

(run-tests selection-sort-tests)
