#lang racket
; construction
(define empty-tree '())
(define (make-tree root left right) (list root left right))
(define (make-leaf root) (make-tree root empty-tree empty-tree))
;getters
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
; validation
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))
(define empty-tree? null?)

;; car - Name
;; cdr - Age
;(list "Ivan" 24 '(("Pencho" 4))
;
;(define (create-person name age occupation)
;  (list name age occupation))
;(define create-person2 cons)
;(define (get-name person)
;  (car person))


(define example (make-tree 1
                           (make-tree 3 (make-leaf 8) empty-tree)
                           (make-tree 7 empty-tree (make-tree 9
                                                              (make-leaf 10)
                                                              (make-leaf 11)))))

(define example-bst (make-tree 8
                               (make-tree 3 (make-leaf 1) (make-tree 6 (make-leaf 4) (make-leaf 7)))
                               (make-tree 10 empty-tree (make-tree 14 (make-leaf 13) empty-tree))))



; Искаме да знаем дали дадено нещо се среща в дадено дърво
(define (member-tree? x tree)
  (if (empty-tree? tree)
      #f
      (or (= (root-tree tree) x)
          (member-tree? x (left-tree tree))
          (member-tree? x (right-tree tree))))
)

(define (map-tree f tree)
  (void)
)

; Искаме да превърнем дърво в списък
(define (tree->list tree)
  (if (empty-tree? tree)
      '()
      (append (tree->list (left-tree tree)) (list (root-tree tree)) (tree->list (right-tree tree))))
)

; Искаме да вземем елементите от нивото, което има най-голяма сума
; Искаме да е списък
(define (level-with-biggest-sum tree)
  (define (get-level tree level)
    (cond ((empty-tree? tree) '())
          ((= level 0) (list (root-tree tree)))
          (else (append (get-level (left-tree tree) (- level 1)) (get-level (right-tree tree) (- level 1))))))

  (define (get-depth tree)
    (if (empty-tree? tree)
        0
        (+ 1 (max (get-depth (left-tree tree)) (get-depth (right-tree tree))))))

  (define (get-tree-levels tree)
    ; '(0 1 2 3)
    ; '((1) (3 7) (8 9) (10 11))
    (define (range->list start end)
      (if (> start end)
          '()
          (cons start (range->list (+ start 1) end))))
    (map (lambda (level) (get-level tree level)) (range->list 0 (- (get-depth tree) 1))))

  (define (bigger-sum xs ys)
    (define (sum xs)
      (foldr + 0 xs))
    (if (> (sum xs) (sum ys)) xs ys))

  ;'((1) (3 7) (8 9) (10 11))
  ;(lambda (current result) (> (sum current) (sum result)) current result)

  (let ((all-tree-levels (get-tree-levels tree)))
    (foldr bigger-sum '() all-tree-levels))
)

; Искаме да проверим дали нещо се среща в дадено двоично наредено дърво
; ама и да се възползваме от това, че дървото е такова
(define (bst-member? x tree)
  (cond ((empty-tree? tree) #f)
        ((= x (root-tree tree)) #t)
        ((< x (root-tree tree)) (bst-member? x (left-tree tree)))
        (else (bst-member? x (right-tree tree))))
)

; Искаме да вмъкнем нещо в дадено двоично наредено дърво и след операцията
; то да си остане такова
(define (bst-insert x tree)
  (void)
)

; Искаме да сортираме списък, използвайки горната функция
(define (bst-sort xs)
  (void)
)

; Искаме елементите на даденото ниво в дърво да станат сумата от поддърветата, на които са корени
(define (compact tree level)
  (void)
)

; Искаме да получим дърво със същите елементи като даденото, но всяко ляво поддърво да стане дясно и обратното
(define (flip tree)
  (void)
)

