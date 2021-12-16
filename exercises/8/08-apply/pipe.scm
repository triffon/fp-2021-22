(require rackunit rackunit/text-ui)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (pipe f . fs)
  (lambda (x)
    ((foldl compose f fs) x)))

(define (partial f . args)
  (lambda (x . rest)
    (apply f (append args (list x) rest))))

(define (square x) (* x x))

(define transform
  (pipe (partial map square)
        (partial filter even?)
        (partial foldl + 0)))

(define partial-tests
  (test-suite
    "Tests for partial"

    (check-equal? (transform '(1 2 3 4 5 6)) 56)))

(run-tests partial-tests)
