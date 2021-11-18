#lang r5rs

(define (str-chr? str c)
  (define (iter i)
    (if (= i (string-length str))
        #f
        (if (eq? c (string-ref str i))
               #t
               (iter (+ i 1)))))
   (iter 0))

(define (str-sub-iter str a b)
  (define (iter i res)
    (if (< i a)
        (iter (+ i 1) res)
        (if (> i b)
            res
            (iter (+ i 1) (string-append res (make-string 1 (string-ref str i)))))))

  (iter 0 ""))


(define (str-sub2 str a b)
  (define (iter i)
    (if (< i a)
        (iter (+ i 1))
        (if (> i b)
            ""
            (string-append (make-string 1 (string-ref str i)) (iter (+ i 1))))))

  (iter 0))

(define (str-sub str a b)
  (if (< b a)
      ""
      (string-append (make-string 1 (string-ref str a)) (str-sub str (+ a 1) b))))

(define (str-starts-with? needle haystack)
  (if (> (string-length needle) (string-length haystack))
      #f
      (equal?
       haystack
       (string-append needle (str-sub haystack (string-length needle) (- (string-length haystack) 1))))))

(define (str-str? needle haystack)
  (if (> (string-length needle) (string-length haystack))
      #f
      (if (str-starts-with? needle haystack)
          0
          (let ((tail-res (str-str? needle (str-sub haystack 1 (- (string-length haystack) 1)))))
            (if tail-res
                tail-res
                #f)))))