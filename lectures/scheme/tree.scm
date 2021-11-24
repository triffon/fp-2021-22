(define (tree? t)
  (or (null? t)
      (and (list t) (= (length t) 3))
           (tree? (cadr t))
           (tree? (caddr t))))

(define empty-tree '())
(define (make-tree root left right) (list root left right))

(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define (make-leaf x) (make-tree x empty-tree empty-tree))

(define t (make-tree 1 (make-leaf 2)
                       (make-tree 3 (make-leaf 4) (make-leaf 5))))

(define (depth-tree t)
  (if (empty-tree? t) 0
      (+ 1 (max (depth-tree (left-tree t))
                (depth-tree (right-tree t))))))

(define (memv-tree x t)
  (cond ((empty-tree? t) #f)            ; лесен лош случай
        ((eqv? (root-tree t) x) t)      ; лесен добър случай
        (else (or (memv-tree x (left-tree t)) (memv-tree x (right-tree t))))))

; (if x x #f) <-> x
; (if x x y)  <-> (or x y)

(define (path-tree x t)
  (cond ((empty-tree? t) #f)
        ((eqv? (root-tree t) x) (list x))
        (else (cons#f (root-tree t) (or (path-tree x (left-tree t)) (path-tree x (right-tree t)))))))

(define (cons#f x l) (if l (cons x l) #f))
(define (cons#f x l) (and l (cons x l)))

;        ((path-tree x (left-tree t))  (cons (root-tree t) (path-tree x (left-tree t))))
;        ((path-tree x (right-tree t)) (cons (root-tree t) (path-tree x (right-tree t))))
;        (else #f)))
  