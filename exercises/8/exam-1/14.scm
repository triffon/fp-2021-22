(require rackunit rackunit/text-ui)

; utilities
(define (maximum-by transform l)
  (foldl (lambda (x max)
           (if (> (transform x) (transform max))
               x
               max))
         (car l)
         (cdr l)))

(define (remove-one l x)
  (cond ((null? l) '())
        ((equal? (car l) x) (cdr l))
        (else (cons (car l)
                    (remove-one (cdr l) x)))))

; selection sort
(define (sort-by transform l)
  (if (null? l)
      '()
      (let ((max-element (maximum-by transform l)))
           (cons max-element
                 (sort-by transform (remove-one l max-element))))))

; interval operations

(define left car)
(define right cdr)

(define (interval-length interval)
  (- (right interval) (left interval)))

; car a [      ] cdr a
;   car b [ ] cdr b
(define (contains? a b)
  (and (<= (left a) (left b))
        (>= (right a) (right b))))

; solution
(define (longest-interval-subsets il)
  (let* ((largest-interval (maximum-by interval-length il))
         (filtered (filter
                    (lambda (interval)
                      (contains? largest-interval interval))
                    il)))
    (sort-by (lambda (interval) (- (left interval))) filtered)))


(define longest-interval-subsets-tests
  (test-suite
    "Tests for longest-interval-subsets"

    (check-equal? (longest-interval-subsets
                    '((24 . 25)
                      (90 . 110)
                      (0 . 100)
                      (10 . 109)
                      (1 . 3)
                      (-4 . 2)))
                    '((0 . 100)
                      (1 . 3)
                      (24 . 25)))))

(run-tests longest-interval-subsets-tests)
