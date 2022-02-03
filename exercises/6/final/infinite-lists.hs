import Prelude hiding (iterate)
import Data.List (transpose)

-- Задача 2. (15 т.) Да се реализира функция comps, която по
-- даден списък от едноместни числови функции fl
-- генерира безкраен поток от всички възможни композиции на функциите във fl,
-- включително и празната композиция (функцията идентитет).
--Пример: comps [f, g] → [id, f, g, f.f, f.g, g.f, g.g, … ]


--concat :: [[a]] -> [a]

comps :: [(Int -> Int)] -> [(Int -> Int)]
comps [] = [id] -- ???
            ---     (\y -> f . y)
comps [f] = iterate (f .) id
-- [id, f . id, f . f . id, f . f . f . id, f . f . f . f, ...]
comps (f:fs) =
    concat -- $ transpose
           $ diags
           $ (map (\h -> map (h .) (comps fs)) (comps [f]))

-- искаме да обходим тази матрица по диагонала ѝ, за да не забием
-- [id, f, f.f, f.f.f, f.f.f.f, f.f.f.f.f, ...]
-- [id         [f             [f.f
-- , g         , f.g          , f.f.g
-- , g.g       , f.g.g        , f.f.g.g
-- , g.g.g     , f.g.g.g      , f.f.g.g.g
-- , g.g.g.g   , f.g.g.g.g    , f.f.g.g.g.g
-- , g.g.g.g.g , f.g.g.g.g.g  , f.f.g.g.g.g.g
-- , ...]      , ...]         , ...]
--
--
--
---m1 =
---    [ [0, 1, 2, 3, 4, 5, 6, 7, 8,  9, 10, ...]
---            ____________________________________
---    , [1, | 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...]
---    , [2, | 3, 4, 5, 6, 7, 8, 9, 10, 11,12, ...]
---    , [3, | 4, 5, 6, 7, 8, 9, 10, 11,12,13, ...]
---    , [4, | 5, 6, 7, 8, 9, 10, 11,12,13,14, ...]
---    , [5, | 6, 7, 8, 9, 10, 11,12,13,14,15 ...]
---    , ...
---    ]
m1 =
    [ [0, 1, 2, 3, 4, 5, 6, 7, 8,  9, 10 ]
            --____________________________________
    , [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
    , [2, 3, 4, 5, 6, 7, 8, 9, 10, 11,12 ]
    , [3, 4, 5, 6, 7, 8, 9, 10, 11,12,13 ]
    , [4, 5, 6, 7, 8, 9, 10, 11,12,13,14 ]
    , [5, 6, 7, 8, 9, 10, 11,12,13,14,15 ]
    ]

imap :: (Int -> a -> b) -> [a] -> [b]
imap f xs =
    go 0 xs
    where
        --go :: Int -> [a] -> [b]
        go i [] = []
        go i (x:xs) = f i x : go (i+1) xs

getDiag :: Int -> [[a]] -> [a]
getDiag 0 m = [head (head m)]
getDiag 1 m = [(m !! 0) !! 1, (m !! 1) !! 0]
getDiag d m =
    let
        firstRow = head m
        firstCol = map head m
    in
    [ firstRow !! d
    , firstCol !! d
    ]
    ++ getDiag (d-2) (map tail (tail m))

diags :: [[a]] -> [[a]]
diags m = map (\d -> getDiag d m) [0..]


iterate :: (a -> a) -> a -> [a]
iterate f x = x : iterate f (f x)
-- [x, fx, ffx, fffx, ffffx, fffffx, ffffffx, ...]




--cartesian xs ys = [(x,y) | x <- xs, y <- ys]














---- диагонално генериране

---m1 =
---    [ [0, 1, 2, 3, 4, 5, 6, 7, 8,  9, 10, ...]
---            ____________________________________
---    , [1, | 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...]
---    , [2, | 3, 4, 5, 6, 7, 8, 9, 10, 11,12, ...]
---    , [3, | 4, 5, 6, 7, 8, 9, 10, 11,12,13, ...]
---    , [4, | 5, 6, 7, 8, 9, 10, 11,12,13,14, ...]
---    , [5, | 6, 7, 8, 9, 10, 11,12,13,14,15 ...]
---    , ...
---    ]


m2 = [[(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9)]
     ,[(1,0),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9)]
     ,[(2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9)]
     ,[(3,0),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9)]
     ,[(4,0),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9)]
     ,[(5,0),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9)]
     ,[(6,0),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9)]
     ,[(7,0),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9)]
     ,[(8,0),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9)]
     ,[(9,0),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9)]]


-- функция, която намира всички числа, които са сбор от кубове на естествени числа
sumOfCubes :: [Int]
sumOfCubes = map (\(x,y) -> x^3 + y^3) pairs

pairsOther =
    concat (diags (map (\i ->
                       map (\j ->
                               (i,j)
                           )
                           [0..])
                   [0..]))

pairs =
    concat (map (\d ->
                map (\i -> (i, d - i))
                    [0..d])
                [0..])
