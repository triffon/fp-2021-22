fact :: Integer -> Integer
fact n = if n == 0
    then 1
    else n * fact (n - 1)

fact' :: Integer -> Integer
fact' n
  | n == 0 = 1
  | n == 1 = 1
  | otherwise = n * fact' (n - 1)

fact'' :: Integer -> Integer
fact'' 0 = 1
fact'' 1 = 1
fact'' n = n * fact'' (n - 1)

sumRange :: Int -> Int -> Int
sumRange a b
  | a > b = b
  | otherwise = a + sumRange (a + 1) b

square :: Num a => a -> a
square x = x ^ 2

fastPow :: Integral a => a -> Int -> a
fastPow x n
  | n == 0 = 1
  | n == 1 = x
  | even n = square (fastPow x (n `div` 2))
  | otherwise = x * fastPow x (n - 1)

elem' :: (Eq a, Fractional a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs) = a == x || elem' a xs
-- elem' a lst = a == head lst || elem' a (tail lst)

reverseNumber :: Int -> Int
reverseNumber x = reverseHelper x 0 where
  -- reverseHelper n acc = if n == 0 then acc else reverseHelper (n `div` 10) (10 * acc + n `mod` 10)
  reverseHelper n acc
    | n == 0 = acc
    | otherwise = reverseHelper (n `div` 10) (10 * acc + n `mod` 10)

-- rangeToList :: Char -> Char -> [Char] -- String
rangeToList :: (Enum a, Ord a) => a -> a -> [a]
rangeToList a b = if a > b then [] else a : rangeToList(succ a) b

getLetterNumber :: Char -> Int
getLetterNumber c = snd (head [t | t <- zip ['a'..'z'] [1..26], fst t == c])
