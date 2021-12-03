-- Зад.1
-- Pattern matching
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- Зад.2
-- Guards
fib1 n
  | n == 0    = 0
  | n == 1    = 1
  | otherwise = fib1 (n - 1) + fib1 (n - 2)

-- if-then-else
fib2 n = if n < 2 then n else fib2 (n - 1) + fib2 (n - 2)

-- case - в този случай ненужен, в други много полезен
fib3 n = case n of 0 -> 0
                   1 -> 1
                   n -> fib3 (n - 1) + fib3 (n - 2)

-- Зад.3
-- Пример за комбинация на pattern matching за простите случаи и гардове за сложните
-- + локални променливи (и функции) с where
fastPow x 0 = 1
fastPow x 1 = x
fastPow x n
  | even n    = sq half
  | otherwise = x * sq half
  where half = fastPow x (n `div` 2)
        sq x = x * x

-- Зад.4
-- Ползване на pattern matching за декомпозиране на структури на съставните им части
--complAdd p1 p2 = (fst p1 + fst p2, snd p1 + snd p2)
complAdd (x1,y1) (x2,y2) = (x1+x2, y1+y2)

-- Зад.6
repeated _ 0 = \x -> x -- идентитет като ламбда функция
repeated f n = f . repeated f (n - 1)
