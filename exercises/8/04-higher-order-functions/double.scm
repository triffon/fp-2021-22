(require rackunit rackunit/text-ui)



(define double-tests
  (test-suite
    "Tests for double"

    (check = ((double inc) 0) 2)
    (check = ((double square) 2) 16)
    (check = ((double (double inc)) 0) 4)
    (check = (((double double) inc) 0) 4)
    (check = (((double (double double)) inc) 0) 16)
    (check = (((double (double double)) inc) 5) 21)))

(run-tests double-tests)
