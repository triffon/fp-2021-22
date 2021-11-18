(require rackunit rackunit/text-ui)

(define (transpose m)
  (apply map list m))

(define (exists? p? l)
  (foldl (lambda (x acc) (or (p? x) acc)) #f l))

(define (for-all? p? l)
  (not (exists? (lambda (x) (not (p? x))) l)))

(define (find-columns matrix)
  (define rows matrix)

  (define (pred? column)
    (exists?
      (lambda (row)
        (for-all?
          (lambda (column-element)
            (member column-element row))
          column))
      rows))

  (define columns (transpose matrix))

  (length (filter pred? columns)))


(define find-columns-tests
  (test-suite
    "Tests for find-columns"

    (check-equal? (find-columns '((1 2) (3 4))) 0)
    (check-equal? (find-columns '((1 4 3) (4 5 6) (7 4 9))) 1)))

(run-tests find-columns-tests)
