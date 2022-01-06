import Prelude

-- class -> създава TypeClass (като Num, Eq, Show, ..)
-- type , data
-- type - нещо като alias 
-- type Age = Int
-- data нещо като Enum

-- Maybe х -> x или нищо ; Optional в swift
-- [Int], [чорапи]

-- data Maybe a = Just a | Nothing

findFirst :: [a] -> (a -> Bool) -> Maybe a
findFirst [] _ = Nothing
findFirst (x:xs) p = if p x then Just x else findFirst xs p

type Age = Int
type Name = String
data Gender = Male | Female | Other deriving (Show, Eq)

data Person = PersonWithName Name Gender Age | PersonWithoutName Gender Age deriving Show

showPersonName :: Person -> Maybe String
showPersonName (PersonWithName name _ _) = Just name
showPersonName (PersonWithoutName _ _) = Nothing

incrementAge :: Person -> Person
incrementAge (PersonWithName name gender age) = PersonWithName name gender (age + 1)
incrementAge (PersonWithoutName gender age) = PersonWithoutName gender (age + 1)

data List a = Nil | Cons a (List a) deriving Show

length' :: List a -> Int
length' Nil = 0
length' (Cons x xs) = 1 + length' xs

map' :: List a -> (a -> b) -> List b
map' Nil _ = Nil
map' (Cons x xs) f = Cons (f x) (map' xs f)

filter' :: List a -> (a -> Bool) -> List a
filter' Nil _ = Nil
filter' (Cons x xs) p = if p x then Cons x (filter' xs p) else filter' xs p

foldr' :: (a -> b -> b) -> b -> List a -> b
foldr' _ nv Nil = nv
foldr' f nv (Cons x xs) = f x (foldr' f nv xs)

-- tree = empty | root left right
data Tree a = Empty | Node a (Tree a) (Tree a)

-- 1. Създайте някакво дърво (по-сложно, да има разклонения)
-- 2. sumElements
-- 3. countLeaves
-- 4. removeLeaves
-- 5. listToTree -> двоично наредено дърво по подаден списък
-- 6. isBST -> дали дадено дърво е двоично наредено