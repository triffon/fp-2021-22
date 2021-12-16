module Lists where

import Prelude hiding (head, tail, null, length,
                       enumFromTo, enumFromThenTo,
                       (++), reverse, (!!), elem,
                       init, last, take, drop,
                       map, filter, foldr, foldl)

head :: [a] -> a
head (h:_) = h

tail :: [a] -> [a]
tail (_:t) = t

null :: [a] -> Bool
null [] = True
null _  = False

{-
length []    = 0
length (_:t) = 1 + length t
-}

length :: [a] -> Int
length l = case l of []    -> 0
                     (_:t) -> 1 + length t

-- 1 + 2:(case x of [] -> 0 ... )

enumFromTo :: (Enum t, Ord t) => t -> t -> [t]
enumFromTo a b
 | a > b     = []
 | otherwise = a : enumFromTo (succ a) b

enumFromThenTo :: (Num t, Ord t) => t -> t -> t -> [t]
enumFromThenTo a a' b
 | a > b     = []
 | otherwise = a : enumFromThenTo (a + dx) (a + 2 * dx) b
   where dx = a' - a

-- !!! enumFromThenTo 'a' 'e' 'z' не работи !!!
-- домашно: enumFromThenTo :: Enum t => t -> t -> t -> [t]

-- (++) [] l = l
(++) :: [a] -> [a] -> [a]
[]    ++ l = l
(h:t) ++ l = h:t ++ l

reverse :: [a] -> [a]
reverse []    = []
reverse (h:t) = reverse t ++ [h]

(!!) :: [a] -> Int -> a
[]    !! _ = error "Невалиден индекс!"
(h:_) !! 0 = h
(_:t) !! n = t !! (n-1)

elem :: Eq a => a -> [a] -> Bool

elem _ []    = False
elem x (h:t) = x == h || elem x t

-- elem x l = not (null l) && (x == head l || elem x (tail l))
x ∈ l = elem x l

елемент_на x l = elem x l

pythagoreanTriples :: Int -> Int -> [(Int,Int,Int)]
pythagoreanTriples a b = [ (x, y, z) | z <- [a..b],
                                       x <- [a..z],
                                       y <- [x+1..z],
                                       z^2 == x^2 + y^2,
                                       gcd x y == 1]

init :: [a] -> [a]
init [_]   = []
init (h:t) = h:init t

last :: [a] -> a
last [a]   = a
last (_:t) = last t

take :: Int -> [a] -> [a]
take 0 _     = []
take _ []    = error "Невалиден брой елементи!"
take n (h:t) = h:take (n-1) t

drop :: Int -> [a] -> [a]
drop 0 l     = l
drop _ []    = error "Невалиден брой елементи!"
drop n (_:t) = drop (n-1) t

f2 = const 2

map :: (a -> b) -> [a] -> [b]
{-
map _ []     = []
map f (x:xs) = f x : map f xs
-}
map f l = [ f x | x <- l ]

filter :: (a -> Bool) -> [a] -> [a]
-- filter p l = [ x | x <- l, p x ]
filter _ [] = []
filter p (x:xs)
 | p x       = x:fxs
 | otherwise = fxs
  where fxs = filter p xs

enumF a = a:enumF (a+1)
