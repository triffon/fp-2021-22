--[1,2,3]
--[]
--[1..10]
--[ x*x  | x <- [1..10], odd x]
--
--[(x,y) | x <- [1..3], y <- [4..6]]

ones :: [Int]
ones = [1,1..]

--factorial 0 = 1
--factorial x = ...
--
--fib 0 = 0
--fib 1 = 1
--fib n = ...

length' :: [Int] -> Int
length' xs = if null xs then 0 else 1 + length' (tail xs)

length'' :: [Int] -> Int
length'' [] = 0
length'' (_:xs) = 1 + length'' xs
-- length'' [1,2,3]
-- x = 1
-- xs = [2,3]
-- 1 + length'' [2,3]

sum' :: [Int] -> Int
sum' [] = 0
sum' (x:xs) = x + sum' xs

sum'' :: [Int] -> Int
sum'' xs
  |null xs = 0
  |otherwise = (head xs) + sum'' (tail xs)

append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = x : (append xs ys)

--reverse :: [a] -> [a]
--reverse [] = []
--reverse (x:xs) = reverse xs ++ [x]

-- take' :: Int -> [a] -> [a]


--[1,1,1,2,2,3,3,3,3,4,5,5]
--[(1,3), (2,2), (3,4), (4,1), (5,2)]
compress :: (Eq a) => [a] -> [(a, Int)]
compress [] = []
compress xs = (createElementTuple equalElements) : compress (drop (length equalElements) xs)
  where equalElements = takeUntilEqual xs


takeUntilEqual :: (Eq a) => [a] -> [a]
takeUntilEqual [] = []
takeUntilEqual (x:xs) = if not (null xs) && x == (head xs)
                        then x : takeUntilEqual xs
                        else [x]

createElementTuple :: (Eq a) => [a] -> (a, Int)
createElementTuple xs = (head xs, length xs)


















-- null 
-- tail == cdr
-- head == car
