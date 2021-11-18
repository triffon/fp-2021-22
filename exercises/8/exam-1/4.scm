(require rackunit rackunit/text-ui)

; x = (sum row) - x
; x + x = (sum row)
; 2x = (sum row)
; x = (sum row) / 2

(define (sum l)
  (foldl + 0 l))

(define (count-rows m)
  (define (pred? row)
    (member (/ (sum row) 2) row))

  (length (filter pred? m)))

(define (transpose m)
  (apply map list m))

(define (count-cols m)
  (count-rows (transpose m)))

(define count-cols-tests
  (test-suite
    "Tests for count-cols"

    (check-equal? (count-cols '((1 2 3 6) (2 3 4 2) (3 4 5 4))) 2)))

(run-tests count-cols-tests)
