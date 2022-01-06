-- Glasgow Haskell Compiler (i = interactive)
-- ghci
-- :load или :l + път към файла
-- :reload или :r след всяка промяна
-- :quit или :q за изход

-- a :: Int
-- a = 7


-- Bool
-- Int
-- Integer
-- Float
-- Double

mySum :: Int -> Int -> Int
mySum a b = a + b

-- mySum' :: Float -> Float -> Float

-- if
myEven n =
  if n `mod` 2 == 0 then True else False

-- като cond
-- Когато използваме гардове (|), нямаме = за тялото на функцията
myOdd n
  | n `mod` 2 == 1 = True
  | otherwise = False

myFactorial :: Int -> Int
myFactorial n =
  if n <= 0 then 1 else n * myFactorial (n - 1)

myFactorial' :: Int -> Int
myFactorial' n
  | n == 0 = 1
  | otherwise = n * myFactorial' (n - 1)

myFactorial'' :: Int -> Int
myFactorial'' 0 = 1
myFactorial'' n = n * myFactorial'' (n - 1)

fib :: Int -> Int
fib n = helper 1 1 1 where
  helper curr prev i
    | i == n = curr
    | otherwise = helper (curr + prev) curr (i + 1)

fib' :: Int -> Int
fib' n = let
  helper curr prev i
    | i == n = curr
    | otherwise = helper (curr + prev) curr (i + 1)
  in helper 1 1 1

-- `` (странични, тези при ~)

-- max a b
-- countDigits n
-- reverseDigits n
-- prime n