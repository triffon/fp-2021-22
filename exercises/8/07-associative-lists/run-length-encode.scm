(require rackunit rackunit/text-ui)

(define (run-length-encode l)
  (define (iterate remaining-list focus-element count result)
    (cond ((null? remaining-list)
                (cons (cons focus-element count) result))
          ((equal? (car remaining-list) focus-element)
                (iterate (cdr remaining-list)
                         focus-element
                         (+ count 1)
                         result))
          (else (iterate (cdr remaining-list)
                         (car remaining-list)
                         1
                         (cons (cons focus-element count) result)))))

  (reverse (iterate (cdr l) (car l) 1 '())))


(define run-length-encode-tests
  (test-suite
    "Tests for run-length-encode"

    (check-equal? (run-length-encode '(8 7 7 2 2 2 2 3 3 2))
                  '((8 . 1) (7 . 2) (2 . 4) (3 . 2) (2 . 1)))))

(run-tests run-length-encode-tests)
