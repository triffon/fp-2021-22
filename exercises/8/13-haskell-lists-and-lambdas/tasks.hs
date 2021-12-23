import Data.List (sortOn, inits, tails)
import Prelude hiding
 ( signum, sum, elem, map, filter, reverse, last, init, (!!)
 , take, drop, splitAt, chunk, takeWhile, dropWhile, zipWith
 , unzip
 )

elem :: Eq t => t -> [t] -> Bool
elem _ [] = False
elem x (h:t) = x == h || elem x t

square x = x * x

map :: (t -> a) -> [t] -> [a]
map _ [] = []
map f (h:t) = f h : map f t


subLists l = sortOn length [
    suffix
  | prefix <- inits l
  , suffix <- tails prefix
  , not . null $ suffix
  ]


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

splitAt n l = (take n l, drop n l)

chunk _ [] = []
chunk n l = let (left, right) = splitAt n l
            in left : chunk n right
-- chunk n l = take n l : chunk n (drop n l)

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

sorted :: Ord a => [a] -> Bool
sorted l = and $ zipWith (<=) l (drop 1 l)

unzip :: [(a, b)] -> ([a], [b])
unzip [] = ([], [])
unzip ((a, b):xs) = let (l1, l2) = unzip xs
                    in (a:l1, b:l2)

-- the following does not work with streams
-- unzip l = traverse l [] []
--   where traverse [] l1 l2 = (l1, l2)
--         traverse ((a, b):xs) l1 l2 = traverse xs (a:l1) (b:l2)

sort [] = []
sort (x:xs) = left ++ [x] ++ right
    where left = sort $ filter (<x) xs
          right = sort $ filter (>x) xs

fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)
--   0|1 1 2 3 5 8 ...
--   +|+ + + + + + +
-- X 1|1 2 3 5 8 ...
-- = =|= = = = = =
-- 0 1|2 3 5 8 13


histogram :: Eq a => [a] -> [(a, Int)]
histogram [] = []
histogram l@(x:xs) = (x, count) : histogram remaining
  where count = length $ filter (==x) l
        remaining = filter (/=x) l

subsequences l = [] : nonEmptySubsequences l

-- works with infinite streams because foldr and (:) are lazy constructive operations
nonEmptySubsequences :: [a] -> [[a]]
nonEmptySubsequences [] = []
nonEmptySubsequences (x:xs) = [x] : foldr addOrNot [] (nonEmptySubsequences xs)
    where addOrNot sub subs = sub:(x:sub):subs

-- examples of how addOrNot works
-- addOrNot [2] [] = [2]:(1:[2]):[]    -> [[2], [1, 2]]
-- addOrNot [3] [[2], [1, 2]] = [3]:(1:[3]):[[2], [1, 2]]  -> [[3], [1, 3], [2], [1, 2]]


main :: IO ()
main = print
  (  elem 2 [1, 2, 3]
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
  && splitAt 3 [1..7] == ([1..3], [4..7])
  && chunk 3 [1..10] == [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
  && takeWhile even [2, 4, 5, 6] == [2, 4]
  && dropWhile even [2, 4, 5, 6] == [5, 6]
  && sortedInsert 5 [1, 3, 4, 7, 8] == [1, 3, 4, 5, 7, 8]
  && zipWith (+) [1, 2, 3] [4, 5, 6, 7] == [5, 7, 9]
  && sorted [1..10]
  && take 10 fibs == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  )
