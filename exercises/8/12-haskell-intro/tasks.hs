import Prelude hiding
 ( signum, sum, elem, map, filter, reverse, last, init, (!!)
 , take, drop, splitAt, chunk, takeWhile, dropWhile, zipWith
 , unzip
 )

add :: Int -> Int -> Int
add a b = a + b

-- addN n = (lambda (x) (+ x n))
-- addN n = \x -> x + n
-- addN n x = add n x
-- addN n = add n
addN = add

-- signum x = if x < 0 then -1 else 1
signum 0 = 0
signum x
  | x > 0 = 1
  | otherwise = -1


factorial :: (Eq p, Num p) => p -> p
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- fib 0 = 0
-- fib 1 = 1
-- fib n = fib (n - 1) + fib (n - 2)


fib n = iter 0 1 0
  where iter current next count
          | count == n = current
          | otherwise = iter next (current + next) (count + 1)


sum start end
  | start == end = start
  | otherwise = start + sum (start + 1) end


square x = x * x

fastPow x 0 = 1
fastPow x 1 = x
fastPow x n
  | even n = square (fastPow x (n `div` 2))
  | otherwise = x * fastPow x (n - 1)


countDigits n
  | n < 10 = 1
  | otherwise = 1 + countDigits (n `div` 10)


-- twice f x = f (f x)

compose f g x = f (g x)
-- compose f g = \x -> f (g x)

twice f = compose f f

repeated :: (Eq t1, Num t1) => (t2 -> t2) -> t1 -> (t2 -> t2)
repeated f 0 = id
repeated f 1 = f
repeated f n = compose f (repeated f (n - 1))


elem _ [] = False
elem x (h:t) = x == h || elem x t
--   | x == h = True
--   | otherwise = elem x t


map :: (t -> a) -> [t] -> [a]
map _ [] = []
map f (h:t) = f h : map f t


filter :: (t -> Bool) -> [t] -> [t]
filter _ [] = []
filter p (h:t)
  | p h = h : filter p t
  | otherwise = filter p t


reverse :: [t] -> [t]
reverse l = iter l []
  where iter [] reversed = reversed
        iter (h:t) reversed = iter t (h:reversed)


last :: [a] -> a
last [] = error "empty list"
last [x] = x
last (x:xs) = last xs

init :: [a] -> [a]
init [] = []
init [x] = []
init (x:xs) = x : init xs

(!!) :: (Eq t, Integral t) => [a] -> t -> a
[] !! _ = error "empty list"
(x:xs) !! 0 = x
(x:xs) !! n = xs !! (n - 1)

take 0 _ = []
take _ [] = []
take n (x:xs) = x : take (n - 1) xs

drop 0 l = l
drop n [] = []
drop n (x:xs) = drop (n - 1) xs

splitAt n l = [take n l, drop n l]

chunk _ [] = []
chunk n l = take n l : chunk n (drop n l)

takeWhile _ [] = []
takeWhile p (x:xs)
  | p x = x : takeWhile p xs
  | otherwise = []

dropWhile _ [] = []
dropWhile p l@(x:xs)
  | p x = dropWhile p xs
  | otherwise = l

sortedInsert x l = takeWhile (<x) l ++ [x] ++ dropWhile (<x) l

zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys

sorted l = and $ zipWith (<=) l (drop 1 l)

unzip :: [(a, b)] -> ([a], [b])
unzip [] = ([], [])
unzip ((a, b):xs) = let (l1, l2) = unzip xs
                    in (a:l1, b:l2)

-- TODO: does not work with streams
-- unzip l = traverse l [] []
--   where traverse [] l1 l2 = (l1, l2)
--         traverse ((a, b):xs) l1 l2 = traverse xs (a:l1) (b:l2)

main :: IO ()
main = print
  (  signum 42 == 1
  && signum (-4) == -1
  && signum 0 == 0
  && factorial 5 == 120
  && fib 7 == 13
  && sum 1 5 == 15
  && fastPow 2 10 == 1024
  && countDigits 12345 == 5
  && compose square square 2 == 16
  && repeated square 2 2 == 16
  && elem 2 [1, 2, 3]
  && map square [1..3] == [1, 4, 9]
  && filter even [1..10] == [2, 4, 6, 8, 10]
  && reverse [1..5] == [5,4..1]

  && last [1..5] == 5
  && init [1..9] == [1..8]
  && [1..10] !! 3 == 4
  && take 3 [1..3] == [1..3]
  && take 3 [1..5] == [1..3]
  && take 30 [1..5] == [1..5]
  && drop 3 [1..10] == [4..10]
  && splitAt 3 [1..7] == [[1..3], [4..7]]
  && chunk 3 [1..10] == [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
  && takeWhile even [2, 4, 5, 6] == [2, 4]
  && dropWhile even [2, 4, 5, 6] == [5, 6]
  && sortedInsert 5 [1, 3, 4, 7, 8] == [1, 3, 4, 5, 7, 8]
  && zipWith (+) [1, 2, 3] [4, 5, 6, 7] == [5, 7, 9]
  && sorted [1..10]
  )
