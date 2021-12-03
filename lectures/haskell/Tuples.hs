module Tuples where

import Prelude hiding (Float)

type Point = (Double, Double)

x :: Point
x = (1.2, 3.4)

type Vector = (Double, Double)

v :: Vector
v = (5.6, 7.8)

z :: Point
z = v

a :: String
a = "Hello"

-- type String = [Char]
b :: [Char]
b = a

-- !!!!!
type Float = Double

f :: Float
f = 1.2

d :: Double
d = f

{-
!!!
f2 :: Prelude.Float
f2 = f
!!!
-}

-- !!! g (x, y) (x, z) = (x, y, z)

