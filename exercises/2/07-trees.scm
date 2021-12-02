(define (make-tree root left right)
  (list root left right))

(define (root tree)
  (car tree))

(define (left-tree tree)
  (cadr tree))

(define (right-tree tree)
  (caddr tree))

;(define (empty-tree? tree)
;  (null? tree))

(define empty-tree? null?)

(define (make-leaf root)
  (list root '() '()))

(define (leaf? tree)
  (and (not (empty-tree? tree))
       (empty-tree (left-tree tree))
       (empty-tree (right-tree tree))))

(define sample-tree
  (make-tree 5
             (make-tree 7
                        (make-tree 4
                                   '()
                                   (make-leaf 0))
                        (make-leaf -2))
             (make-tree -1
                        (make-tree 10
                                   (make-leaf 3)
                                   (make-tree 8
                                              (make-leaf 1)
                                              '()))
                        '())))

(define (height tree)
  (if (empty-tree? tree)
      0
      (+ 1 (max (height (left-tree tree))
                (height (right-tree tree))))))

(define (map-tree f tree)
  (if (empty-tree? tree)
      '()
      (make-tree (f (root tree))
                 (map-tree f (left-tree tree))
                 (map-tree f (right-tree tree)))))

(define (level tree n)
  (cond ((empty-tree? tree) '())
        ((= n 0) (list (root tree)))
        (else (append (level (left-tree tree) (- n 1))
                      (level (right-tree tree) (- n 1))))))

(define (transpose m)
  (apply map list m))

(define matrix '((1 2 3)
                 (4 5 6)))

(define arithmetic-tree
  (make-tree +
             (make-tree -
                        (make-leaf 4)
                        (make-leaf 3))
             (make-tree +
                        (make-tree /
                                   (make-leaf 12)
                                   (make-leaf 4))
                        (make-leaf -2))))

(define (calculate tree)
  (let ((r (root tree)))
    (if (procedure? r)
        (r (calculate (left-tree tree))
           (calculate (right-tree tree)))
        r)))

(define BST
  (make-tree 10
             (make-tree 3
                        (make-tree -1 (make-leaf -3) (make-leaf 2))
                        (make-leaf 7))
             (make-tree 11
                        '()
                        (make-tree 20
                                   (make-leaf 15)
                                   '()))))

(define (contains? bst elem)
  (cond ((empty-tree? bst) #f)
        ((= elem (root bst)) #t)
        ((< elem (root bst)) (contains? (left-tree bst) elem))
        (else (contains? (right-tree bst) elem))))

(define (insert bst elem)
  (cond ((empty-tree? bst) (make-leaf elem))
        ((< elem (root bst)) (make-tree (root bst)
                                        (insert (left-tree bst) elem)
                                        (right-tree bst)))
        (else (make-tree (root bst)
                         (left-tree bst)
                         (insert (right-tree bst) elem)))))

; in-order traversal (left root right)
(define (traverse tree)
  (if (empty-tree? tree)
      '()
      (append (traverse (left-tree tree))
              (list (root tree))
              (traverse (right-tree tree)))))