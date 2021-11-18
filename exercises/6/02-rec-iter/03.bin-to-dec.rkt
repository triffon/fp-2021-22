#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 3
; Преобразуване от двоична в десетична бройна система.
; > Забележка: тук под бройна система разбираме просто използваните цифри в
; представянето на числото. Тоест няма създаваме двоични числа, започващи с #b.
; Фактически работим само с десетични числа в Scheme.

(define (bin-to-dec n)
  'тук)

(run-tests
  (test-suite
    "bin-to-dec tests"
    (check = (bin-to-dec 0) 0)
    (check = (bin-to-dec 1) 1)
    (check = (bin-to-dec 100) 4)
    (check = (bin-to-dec 1111) 15)
    (check = (bin-to-dec 110111) 55)
    (check = (bin-to-dec 111010110111) 3767))
  'verbose)

