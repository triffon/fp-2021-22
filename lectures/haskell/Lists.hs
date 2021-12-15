module Lists where

import Prelude hiding (head, tail, null, length,
                       enumFromTo, enumFromThenTo,
                       (++), reverse, (!!), elem)

head (h:_) = h

tail (_:t) = t

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

enumFromTo a b
 | a > b     = []
 | otherwise = a : enumFromTo (succ a) b

enumFromThenTo a a' b
 | a > b     = []
 | otherwise = a : enumFromThenTo (a + dx) (a + 2 * dx) b
   where dx = a' - a

-- !!! enumFromThenTo 'a' 'e' 'z' не работи !!!

-- (++) [] l = l
[]    ++ l = l
(h:t) ++ l = h:t ++ l

reverse :: [a] -> [a]
reverse []    = []
reverse (h:t) = reverse t ++ [h]

[]    !! _ = error "Невалиден индекс!"
(h:_) !! 0 = h
(_:t) !! n = t !! (n-1)

elem :: Eq a => a -> [a] -> Bool

elem _ []    = False
elem x (h:t) = x == h || elem x t

-- elem x l = not (null l) && (x == head l || elem x (tail l))
x ∈ l = elem x l

елемент_на x l = elem x l

pythagoreanTriples a b = [ (x, y, z) | x <- [a..b],
                                       y <- [x+1..b],
                                       z <- [a..b],
                                       gcd x y == 1,
                                       z^2 == x^2 + y^2 ]
