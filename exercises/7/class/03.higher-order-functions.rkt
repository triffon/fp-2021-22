#lang racket

(define (sum-interval start end)
  (if (> start end)
      0
      (+ start (sum-interval (+ start 1) end)))
)

(define (sum-interval-iterative start end)
  (define (sum-interval start end result)
    (if (> start end)
        result
        (sum-interval (+ start 1) end (+ start result))))
  (sum-interval start end 0))

(define (product-interval start end)
  (if (> start end)
      1
      (* start (sum-interval (+ start 1) end)))
)

(define (sum-interval-even start end)

)

(define (sum-cubes-interval start end)

)