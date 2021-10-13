(require rackunit rackunit/text-ui)



(define count-palindromes-tests
  (test-suite
    "Tests for count-palindromes"

    (check = (count-palindromes 1 5) 5)
    (check = (count-palindromes 0 10) 10)
    (check = (count-palindromes 11 100) 9)
    (check = (count-palindromes 101 1000) 90)))

(run-tests count-palindromes-tests)
