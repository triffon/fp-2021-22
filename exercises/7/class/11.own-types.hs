import Prelude hiding (length)
--(cons 1 2)
--(cons 1 (cons 2 '() '()) '())
--(cons 1 (cons 2 '()))

type Name = String
type Point = (Int,Int)
type SmallTree = (Int, Int, Int)
type Graph a = [(Int, [a])]

children :: Graph a -> Int -> [a]
children g v = snd $ head $ filter (\gv -> fst gv == v) g

--addPoints :: Point -> Point -> Point
--addPoints (x1,y1) (x2,y2) =


-- class / enum
type Age = Int
type Id = String

data Person = Person Name Age | PersonWithId Name Id deriving (Show)

instance Eq Person where
  (Person name1 _) == (Person name2 _) = name1 == name2
  (PersonWithId name1 _) == (PersonWithId name2 _) = name1 == name2


greet :: Person -> String
greet (Person name _) = "Hello, " ++ name
greet (PersonWithId name _) = "Hello, " ++ name

-- class Person
--
-- new Person("Ivan", 20);

data List a = Empty | Cons a (List a) deriving Show

exampleList :: List Int
exampleList = Cons 2 (Cons 3 (Cons 4 Empty))

length :: List a -> Int
length Empty = 0
length (Cons _ xs) = 1 + length xs

data Tree a = EmptyTree | Node (Tree a) a (Tree a) deriving Show

leaf :: a -> Tree a
leaf x = Node EmptyTree x EmptyTree

exampleTree :: Tree Int
exampleTree = Node (leaf 3) 2 (Node (leaf 4) 5 (leaf 6))

-- колко елемента има в дървото
count :: Tree a -> Int
count EmptyTree = 0
count (Node left _ right) = 1 + (count left) + (count right)

--sum :: (Num a) => Tree a -> a

--nThLevel :: Tree a -> Int -> [a]

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ EmptyTree = EmptyTree
mapTree f (Node left root right) = Node (mapTree f left) (f root) (mapTree f right)

-- data Maybe a = Nothing | Just a deriving Show

findElement :: (a -> Bool) -> [a] -> Maybe a
findElement _ [] = Nothing
findElement p (x:xs)
  |p x = Just x
  |otherwise = findElement p xs

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

applyToMaybe :: (a -> b) -> Maybe a -> Maybe b
applyToMaybe _ Nothing = Nothing
applyToMaybe f (Just x) = Just $ f x

applyToElement :: (a -> b) -> (a -> Bool) -> [a] -> Maybe b
applyToElement f p xs = case findElement p xs of
                          Just x -> Just $ f x
                          Nothing -> Nothing

