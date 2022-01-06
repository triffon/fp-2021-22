module Lazy where

-- ones = 1 : ones

-- (define ones (cons 1 ones))

ones = repeat 1

{-
repeated 0 f z = z
repeated n f z = f (repeated (n-1) f z)
-}

-- repeated n f z = iterate f z !! n

-- pairs = [ (x,y) | x <- [0..], y <- [0..] ]
-- pairs = [ (t, x - t) | x <- [0..], t <- [0..x] ]
pairs = [ (x, y) | x <- [0..], y <- [0..], n <- [0..], x + y == n ]

triplets = iterate (map (+3)) [3,2,1]

repeated = (foldr (.) id .) . replicate

-- f x = f (1 - x)
-- f x = seq x f (1 - x)
f x = f $! (1-x)
second _ y = y
