(require rackunit rackunit/text-ui "tree.scm")

(define (level tree n)
  (cond ((empty-tree? tree) '())
        ((= n 0) (list (root-tree tree)))
        (else (append (level (left-tree tree) (- n 1))
                      (level (right-tree tree) (- n 1))))))

(define tree
  (make-tree 5
             (make-tree 13
                        (make-leaf 4)
                        (make-leaf 9))
             (make-tree 7
                        (make-leaf 2)
                        (make-tree 15
                                   (make-leaf 1)
                                   (make-tree 5
                                              (make-leaf 42)
                                              (make-leaf 19))))))

(define level-tests
  (test-suite
    "Tests for level"

    (check-equal? (level tree 0) '(5))
    (check-equal? (level tree 1) '(13 7))
    (check-equal? (level tree 2) '(4 9 2 15))
    (check-equal? (level tree 3) '(1 5))
    (check-equal? (level tree 4) '(42 19))))

(run-tests level-tests)
