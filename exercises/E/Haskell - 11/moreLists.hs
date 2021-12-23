foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f acc [] = acc
foldr' f acc (x:xs) = f x (foldr' f acc xs)

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' f acc [] = acc
foldl' f acc (x:xs) = foldl' f (f acc x) xs

-- repeat
-- [1..]
-- спира се с ctrl + C

second :: (a, b) -> b
second (_,b) = b

quickSort :: Ord a => [a] -> [a] -- <, >, <=
quickSort [] = []
quickSort (pivot:rest) = lessThan ++ [pivot] ++ moreThan where
  lessThan = quickSort [x | x <- rest, x <= pivot]
  moreThan = quickSort [x | x <- rest, x > pivot]

ones :: [Int]
ones = repeat 1

makeSet :: Eq a => [a] -> [a]
makeSet [] = []
makeSet (x:xs) = x : makeSet (filter (/= x) xs)