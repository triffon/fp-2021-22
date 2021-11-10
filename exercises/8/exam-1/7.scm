(require rackunit rackunit/text-ui)

(define (for-all? p? l)
  (foldl (lambda (x acc) (and acc (p? x))) #t l))

(define (exists? p? l)
  (not (for-all? (lambda (x) (not (p? x))) l)))

; f трансформира l1 в l2: ∀x∈l₁ f(x)∈l₂
(define (transforms? f l1 l2)
  (for-all? (lambda (x) (member (f x) l2)) l1))

; f покрива изцяло l2: ∀y∈l₂ ∃x∈l₁ f(x)=y
(define (covers? f l1 l2)
  (for-all?
    (lambda (y)
      (exists?
        (lambda (x) (equal? (f x) y))
        l1))
    l2))

(define (is-sur? f l1 l2)
  (and (transforms? f l1 l2)
       (covers? f l1 l2)))

(define (square x) (* x x))

(define is-sur?-tests
  (test-suite
    "Tests for is-sur?"

    (check-true (is-sur? square '(0 1 -1 2) '(0 1 4)))))

(run-tests is-sur?-tests)
