(require "tree.scm")

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

(define (count-leaves tree)
  (cond ((empty-tree? tree) 0)
        ((leaf-tree? tree) 1)
        (else (+ (count-leaves (left-tree tree))
                 (count-leaves (right-tree tree))))))

; (display (count-leaves tree))


(define (map-tree f tree)
  (cond ((empty-tree? tree) the-empty-tree)
        (else (make-tree (f (root-tree tree))
                         (map-tree f (left-tree tree))
                         (map-tree f (right-tree tree))))))

; (define (square x) (* x x))
; (display (map-tree square tree))


(define (height-tree tree)
  (cond ((empty-tree? tree) 0)
        (else (+ 1 (max (height-tree (left-tree tree))
                        (height-tree (right-tree tree)))))))

; (display (height-tree tree))

(define (invert-tree tree)
  (cond ((empty-tree? tree) the-empty-tree)
        (else (make-tree (root-tree tree)
                         (invert-tree (right-tree tree))
                         (invert-tree (left-tree tree))))))

; (display (invert-tree tree))


(define (binary-heap? tree)
  (cond ((empty-tree? tree) #t)
        (else (and
                (or (empty-tree? (left-tree tree))
                    (< (root-tree tree) (root-tree (left-tree tree))))
                (or (empty-tree? (right-tree tree))
                    (< (root-tree tree) (root-tree (right-tree tree))))
                (binary-heap? (left-tree tree))
                (binary-heap? (right-tree tree))))))

(define tree
  (make-tree 5
             (make-tree 13
                        (make-leaf 94)
                        (make-leaf 99))
             (make-leaf 42)))

; (display (binary-heap? tree))


(define (binary-search-tree? tree)
  (cond ((empty-tree? tree) #t)
        (else (and
                (or (empty-tree? (left-tree tree))
                    (> (root-tree tree) (root-tree (left-tree tree))))
                (or (empty-tree? (right-tree tree))
                    (< (root-tree tree) (root-tree (right-tree tree))))
                (binary-search-tree? (left-tree tree))
                (binary-search-tree? (right-tree tree))))))


(define tree
  (make-tree 4
             (make-tree 2
                        (make-leaf 1)
                        (make-leaf 3))
             (make-leaf 10)))

; (display (binary-search-tree? tree))

(define (insert tree v)
  (cond ((empty-tree? tree) (make-leaf v))
        ((> (root-tree tree) v) ; root > v, then keep the right and insert in the left
          (make-tree (root-tree tree)
                     (insert (left-tree tree) v)
                     (right-tree tree)))
        (else ; root <= v, then keep the left subtree and insert in the right
          (make-tree (root-tree tree)
                     (left-tree tree)
                     (insert (right-tree tree) v)))))

; (display (insert tree 11))


(define (in-order tree)
  (if (empty-tree? tree)
      '()
      (append (in-order (left-tree tree))
              (list (root-tree tree))
              (in-order (right-tree tree)))))

(define (tree-sort l)
  (in-order
    (foldl
      (lambda (x tree) (insert tree x))
      the-empty-tree
      l)))

(display (tree-sort '(8 6 2 0 9 4 3 1)))
