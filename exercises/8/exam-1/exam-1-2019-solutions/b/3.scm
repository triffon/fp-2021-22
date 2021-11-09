(require rackunit rackunit/text-ui)

(define (deep-delete-iter l level)
  (cond ((null? l) '())
        ((null? (car l)) (cons '() (deep-delete-iter (cdr l) level)))
        ((pair? (car l)) (cons (deep-delete-iter (car l) (+ level 1))
                               (deep-delete-iter (cdr l) level)))
        ((< (car l) level) (deep-delete-iter (cdr l) level))
        (else (cons (car l)
                    (deep-delete-iter (cdr l) level)))))

(define (deep-delete l)
  (deep-delete-iter l 1))

(define deep-delete-tests
  (test-suite
    "Tests for deep-delete"

    (check-equal? (deep-delete '()) '())
    (check-equal? (deep-delete '(())) '(())) ; the tricky test
    (check-equal? (deep-delete '(1 (2 (2 4) 1) 0 (3 (1))))
                  '(1 (2 (4)) (3 ())))))

(run-tests deep-delete-tests)
