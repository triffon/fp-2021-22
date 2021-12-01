(require rackunit rackunit/text-ui)

(define (zip-with f l1 l2)
  (if (or (null? l1) (null? l2))
      '()
      (cons (f (car l1) (car l2))
            (zip-with f (cdr l1) (cdr l2)))))

(define zip-with-tests
  (test-suite
    "Tests for zip-with"

    (check-equal? (zip-with + '(1 3 5 7 9) '(2 4 6 8 9))
                  '(3 7 11 15 18))))

(run-tests zip-with-tests)


(define (exists? p? l)
  (foldl (lambda (x acc) (or (p? x) acc)) #f l))

(define (zip-with* f . ll)
  (if (exists? null? ll)
      '()
      (cons (apply f (map car ll))
            (apply zip-with* f (map cdr ll)))))

(define zip-with*-tests
  (test-suite
    "Tests for zip-with*"

    (check-equal? (zip-with* + '(1 2) '(3 4) '(5 6 7))
                  '(9 12))))

(run-tests zip-with*-tests)
