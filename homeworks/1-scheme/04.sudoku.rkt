#lang racket
(require rackunit rackunit/text-ui)

;### Зад 4
; Дали полето `board` изпълнява правилата на судоку - всеки ред, колона и
; всяко 3x3 подполе да съдържа точно всички елементи от `alphabet`.
(define (sudoku-solved? alphabet board)
  'тук)


(define board1
  '((5 3 4  6 7 8  9 1 2)
    (6 7 2  1 9 5  3 4 8)
    (1 9 8  3 4 2  5 6 7)

    (8 5 9  7 6 1  4 2 3)
    (4 2 6  8 5 3  7 9 1)
    (7 1 3  9 2 4  8 5 6)

    (9 6 1  5 3 7  2 8 4)
    (2 8 7  4 1 9  6 3 5)
    (3 4 5  2 8 6  1 7 9)))

(define board2
  '((3 8 7  4 1 6  5 2 9)
    (6 4 5  9 2 7  8 3 1)
    (2 1 9  3 8 5  7 4 6)

    (9 2 4  1 6 8  3 7 5)
    (7 3 1  5 4 2  6 9 8)
    (8 5 6  7 3 9  4 1 2)

    (5 7 3  6 9 1  2 8 4)
    (1 6 8  2 7 4  9 5 3)
    (4 9 2  8 5 3  1 6 7)))

(define board1-grid
  '((5 3 4  6 7 8 9 1 2)
    (6 7 5  1 9 2 3 4 8)
    (1 9 8  3 4 2 5 6 7)

    (8 5 9  7 6 1 4 2 3)
    (4 2 6  8 5 3 7 9 1)
    (7 1 3  9 2 4 8 5 6)
    (9 6 1  5 3 7 2 8 4)
    (2 8 7  4 1 9 6 3 5)
    (3 4 5  2 8 6 1 7 9)))
(define board1-row
  '((5 3 4 5 7 8 9 1 2)
    (6 7 2 1 9 5 3 4 8)
    (1 9 8 3 4 2 5 6 7)
    (8 5 9 7 6 1 4 2 3)
    (4 2 6 8 5 3 7 9 1)
    (7 1 3 9 2 4 8 5 6)
    (9 6 1 5 3 7 2 8 4)
    (2 8 7 4 1 9 6 3 5)
    (3 4 5 2 8 6 1 7 9)))
(define board1-col
  '((5 3 4 6 7 8 9 1 2)
    (6 7 2 1 9 5 3 4 8)
    (1 9 8 3 4 2 5 6 7)
    (8 5 9 7 6 1 4 2 3)
    (4 2 6 8 5 3 7 9 1)
    (7 1 3 9 2 4 8 5 6)
    (9 6 1 5 3 7 5 8 4)
    (2 8 7 4 1 9 6 3 5)
    (3 4 5 2 8 6 1 7 9)))
(define board2-false
  '((3 8 7  4 1 6  5 2 9)
    (6 4 5  9 2 7  8 3 1)
    (2 1 9  3 8 5  7 4 6)

    (9 2 4  1 6 8  3 7 5)
    (7 3 1  #f 4 2  6 9 8)
    (8 5 6  7 3 9  4 1 2)

    (5 7 3  6 9 1  2 8 4)
    (1 6 8  2 7 4  9 5 3)
    (4 9 2  8 5 3  1 6 7)))

(define board1-roman
  '((V III IV  VI VII VIII  IX I II)
    (VI VII II  I IX V  III IV VIII)
    (I IX VIII  III IV II  V VI VII)

    (VIII V IX  VII VI I  IV II III)
    (IV II VI  VIII V III  VII IX I)
    (VII I III  IX II IV  VIII V VI)

    (IX VI I  V III VII  II VIII IV)
    (II VIII VII  IV I IX  VI III V)
    (III IV V  II VIII VI  I VII IX)))

(define board3-letters
  '((w p e  k a r  i b d)
    (d i a  b w p  k e r)
    (r b k  e i d  p a w)

    (p e r  i k w  a d b)
    (i w b  d p a  r k e)
    (k a d  r b e  w p i)

    (b k w  a e i  d r p)
    (a d p  w r b  e i k)
    (e r i  p d k  b w a)))
(define board3-dup
  '((w p e  k a r  i b d)
    (d i a  b w p  k e r)
    (r b k  e i d  p a w)

    (p e r  i w w  a d b)
    (i w b  d p a  r k e)
    (k a d  r b e  w p i)

    (b k w  a e i  d r p)
    (a d p  w r b  e i k)
    (e r i  p d k  b w a)))

(define digits '(1 2 3 4 5 6 7 8 9))
(define digits-perm '(7 5 3 9 8 1 2 6 4))
(define roman-numbers '(I II III IV V VI VII VIII IX))
(define letters '(a b d e i k p r w))

(run-tests
  (test-suite "sudoku-solved? tests"
    (check-true (sudoku-solved? digits board1))
    (check-true (sudoku-solved? digits board2))
    (check-false (sudoku-solved? digits board1-grid))
    (check-false (sudoku-solved? digits board1-row))
    (check-false (sudoku-solved? digits board1-col))
    (check-false (sudoku-solved? digits board2-false))

    (check-true (sudoku-solved? digits-perm board1))
    (check-true (sudoku-solved? digits-perm board2))
    (check-false (sudoku-solved? digits-perm board1-grid))
    (check-false (sudoku-solved? digits-perm board1-row))
    (check-false (sudoku-solved? digits-perm board1-col))
    (check-false (sudoku-solved? digits-perm board2-false))

    (check-true (sudoku-solved? roman-numbers board1-roman))
    (check-true (sudoku-solved? letters board3-letters))
    (check-false (sudoku-solved? letters board3-dup)))
  'verbose)
