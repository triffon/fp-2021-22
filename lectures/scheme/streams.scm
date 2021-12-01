(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))

(define-syntax my-delay (syntax-rules () ((my-delay x) (lambda () x))))
(define (my-force promise) (promise))

(define the-empty-stream '())
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))
;; (define (cons-stream h t) (cons h (delay t))) ;; !!! 
(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?)

(define s (cons-stream 1 (cons-stream 2 (cons-stream 3 the-empty-stream))))
(define s2 (cons-stream 1 (cons-stream b the-empty-stream)))

;; #define f(x) x+x

(define (enum a b)
  (if (> a b) the-empty-stream
      (cons-stream a (enum (+ a 1) b))))

(define (take n s)
  (if (= n 0) '()
      (cons (head s) (take (- n 1) (tail s)))))

(define (search-stream p? s)
  (cond ((empty-stream? s) #f)
        ((p? (head s)) s)
        (else (search-stream p? (tail s)))))

(define (from n)
  (cons-stream n (from (+ n 1))))

(define nats (from 0))

(define (generate-fibs a b)
  ; генерира поток от числата на Фибоначи от a нататък, ако знаем, че първите две числа в потока са a и b
  (cons-stream a (generate-fibs b (+ a b))))
(define fibs (generate-fibs 0 1))

; (define (map-stream f s)
;  (cons-stream (f (head s)) (map-stream f (tail s))))

(define (map-stream f . streams)
  (cons-stream (apply f (map head streams))
               (apply map-stream f (map tail streams))))

(define (filter-stream p? s)
  (if (p? (head s)) (cons-stream (head s) (filter-stream p? (tail s)))
      (filter-stream p? (tail s))))

(define ones (cons-stream 1 ones))

;; !!!! (define (tail nats) (map-stream + ones nats))
;; (define nats (cons-stream 0 (map-stream + ones nats)))
(define (1+ x) (+ x 1))
(define nats (cons-stream 0 (map-stream 1+ nats)))

(define fibs
  (cons-stream 0
               (cons-stream 1 (map-stream + fibs (tail fibs)))))

(define (notdivides d)
  (lambda (n) (> (remainder n d) 0)))

(define (sieve stream)
  (cons-stream (head stream)
               (sieve (filter-stream (notdivides (head stream)) (tail stream)))))

(define primes (sieve (from 2)))
