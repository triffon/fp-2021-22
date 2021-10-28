# Функции от по-висок ред. Accumulate (упр 3)

#### [Сваляне на задачите][download]

### [Зад 1 `fact` и `fib`][fib-fact]
Имплементирайте `fact` и `fib` чрез [`accumulate`][common].

> Задачата за `fib` чрез `accumulate` не е особено трудна, стига да знаете формулата,
която се извежда по интересен начин от триъгълника на Паскал.
[Wikipedia](https://en.wikipedia.org/wiki/Fibonacci_number#Mathematics).

### [Зад 2 `newton-binomial`][newton-binomial]
[Нютонов бином][newton-wiki] чрез [`accumulate`][common].

### [Зад 3 `count-palindromes`][count-palindromes]
Броят на целите числа палиндроми в интервала [a, b].

### [Зад 4 `flip`][flip]
Функцията `flip`, която приема като аргумент функция на два аргумента `f`, и връща `f` с разменени аргументи.

### [Зад 5 `complement-bool`][complement-bool]
Приема предикат `pred?` и връща предикат, който отговаря на отрицанието на `pred?`.

### [Зад 6 `prime?-acc`][prime?-acc]
Имплементирайте `prime?` чрез [`accumulate` или `accumulate-i`][common]

### [Зад 7 `exists-int?`][exists-int?]
Дали **има** цяло число в интервала [a, b], за което предикатът `pred?` е истина?

### [Зад 8 `all-int?`][all-int?]
Дали **за всяко** цяло число в интервала [a, b] предикатът `pred?` е истина?

### [Зад 9 `count-p`][count-p]
Броят на числата, удовлетворяващи предиката `pred?` сред числата `a`, `(next a)`, `(next (next a))`, ..., `b`.

### [Зад 10 `maximum-digit-sum`][maximum-digit-sum]
Най-голямата сума на цифрите на цяло число от интервала [a, b].

### [Зад 11 `count-pairs-gcd`][count-pairs-gcd] **за домашно (4т.)**
Броят на наредените двойки цели числа (`x`,`y`) от интервала [a,b], които имат най-голям общ делител равен на `n`.

[newton-wiki]: https://en.wikipedia.org/wiki/Binomial_theorem
[download]: https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Ftriffon%2Ffp-2021-22%2Ftree%2Fmaster%2Fexercises%2F6%2F03-higher-order--accumulate

[common]: ./common.03.rkt
[fib-fact]: ./01.fib-fact.rkt
[newton-binomial]: ./02.newton-binomial.rkt
[count-palindromes]: ./03.count-palindromes.rkt
[flip]: ./04.flip.rkt
[complement-bool]: ./05.complement-bool.rkt
[prime?-acc]: ./06.prime-acc.rkt
[exists-int?]: ./07.exists-int.rkt
[all-int?]: ./08.all-int.rkt
[count-p]: ./09.count-p.rkt
[maximum-digit-sum]: ./10.maximum-digit-sum.rkt
[count-pairs-gcd]: ./11.count-pairs-gcd.rkt
