(require rackunit rackunit/text-ui)

(define (concat ll)
  (apply append ll))

(define (repeat x n)
  (if (= n 0)
      '()
      (cons x (repeat x (- n 1)))))

; map each tuple to a list
; (1 . 2) -> (list 1 1)
; (3 . 4) -> (list 3 3 3 3)
; (5 . 2) -> (list 5 5)
; then concatenate the lists
(define (run-length-decode l)
  (let* (
    (lists (map (lambda (tuple) (repeat (car tuple) (cdr tuple))) l)))
    (concat lists)))

(define run-length-decode-tests
  (test-suite
    "Tests for run-length-decode"

    (check-equal? (run-length-decode '((1 . 2) (3 . 4) (5 . 2)))
                  '(1 1 3 3 3 3 5 5))))

(run-tests run-length-decode-tests)
