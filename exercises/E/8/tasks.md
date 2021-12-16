# От миналия път:

1. leaves
2. pre-order -> искаме списък

# Загрявка:

3. bst-member? x t -> t е двоично наредено дърво, х е елемент. Искаме да проверим дали х се среща в t
4. bst-insert x t -> t е двоично наредено дърво, х е елемент. Искаме да добавим х в t на правилното място
5. flip-tree -> да обърнем дадено двоично дърво - всяко ляво поддърво да стане дясно и обратно

# Потоци
https://docs.racket-lang.org/reference/streams.html
!!! (require racket/stream)

6. stream-form-interval
7. stream-to-list
8. stream-from-list
9. ones -> поток от единици
10. n-stream -> поток от всички числа, започващи от n
11. my-stream-take -> поток от първите n елемента на даден поток
12. add-streams -> поток от сбора на два потока
13. fib-stream -> поток от числата на Фибоначи
14. repeat-list -> прави безкраен поток от елементите на списък l
15. iterate x f -> безкраен поток от типа x, f(x), f(f(x)), ...