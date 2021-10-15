# Рекурсивен vs. итеративен процес
  - извиквания
  - пресмятания

## Примери

Factorial

```
(define (fact n)
  (if (= n 0)
    1
    (* n (fact (- n 1)))
  )
)

(define (factorial n)
  (define (fact-iter n product)
    (if (= n 0)
      product
      (fact-iter (- n 1) (* product n))
    )
  )
)
```

Fibonacci

```
(define (fib n)
  (if (<= n 2)
    1
    (+ (fib (- n 1))
       (fib (- n 2))
    )
  )
)


(define (fib-iter n)
  (define (helper counter curr prev)
    (if (= counter n) 
      curr 
      (helper (+ counter 1) (+ curr prev) curr)
    )
  )
  (helper 1 1 0))
```

## Да решаваме:

1. count-digits -> брои цифрите на подадено число
2. sum-digits -> сумира цифрите на подадено число
3. prime? -> проверява дали дадено число е просто
4. count-digits-iter
5. sum-digits-iter
6. automorphic? -> проверява дали квадрата на подадено число завършва с числото
7. dec-to-bin -> връща двоичния запис на подадено число в десетична бройна система
8. bin-to-dec -> guess :D