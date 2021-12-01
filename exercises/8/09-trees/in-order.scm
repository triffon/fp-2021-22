(require rackunit rackunit/text-ui "tree.scm")

; left-root-right traversal
(define (in-order tree)
  (if (empty-tree? tree)
      '()
      (append (in-order (left-tree tree))
              (list (root-tree tree))
              (in-order (right-tree tree)))))

(define tree
  (make-tree 5
             (make-tree 13
                        (make-leaf 4)
                        (make-leaf 9))
             (make-tree 7
                        (make-leaf 2)
                        (make-tree 15
                                   (make-leaf 1)
                                   (make-leaf 5)))))

(define small-tree (left-tree tree))

(define another-tree (right-tree tree))

(define in-order-tests
  (test-suite
    "Tests for in-order"

    (check-equal? (in-order the-empty-tree) '())
    (check-equal? (in-order (make-leaf 4)) '(4))
    (check-equal? (in-order small-tree) '(4 13 9))
    (check-equal? (in-order another-tree) '(2 7 1 15 5))
    (check-equal? (in-order tree) '(4 13 9 5 2 7 1 15 5))))

(run-tests in-order-tests)
