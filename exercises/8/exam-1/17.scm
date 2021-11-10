(require rackunit rackunit/text-ui)

; creates a list of all integers in the given interval
; example: (range '(1 . 5)) -> '(1 2 3 4 5)
(define (range a b)
  (if (> a b)
      '()
      (cons a (range (+ a 1) b))))

(define (flatten ll)
  (foldl append '() ll))

; enumerates all intervals (i, j)
; such that: a <= i < j <= b
;
; in a procedural language it would work like so:
;     intervals = []
;     for i in range(a, b):
;       for j in range(i + 1, b):
;         intervals.append((i, j))
;
; example: (enumerate 1 3) -> '((2 . 3) (1 . 2) (1 . 3))
(define (enumerate a b)
  (flatten
    (map (lambda (i)
           (map (lambda (j)
             (cons i j))
           (range (+ i 1) b)))
         (range a b))))

(define (foldr1 op l)
  (if (null? (cdr l))
      (car l)
      (op (car l)
          (foldr1 op (cdr l)))))

(define left car)
(define right cdr)

(define (find-max f a b)
  (let* ((intervals (enumerate a b))
         (values (map (lambda (interval)
                        (foldr1 f (range (left interval)
                                         (right interval))))
                      intervals)))
    (foldr1 max values)))

(define find-max-tests
  (test-suite
    "Tests for find-max"

    (check-equal? (find-max - 1 5) 4)))

(run-tests find-max-tests)
