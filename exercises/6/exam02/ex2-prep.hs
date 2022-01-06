--  sumLast 3 5 → [3, 3, 6, 12, 24, 48, 93, 183, ... ]
-- Задача 2 (8 т.) [Scheme/Haskell] Да се напише функция sumLast, която
-- приема две положителни естествени числа k и n и генерира безкрайния
-- поток, в който първото число е k, а всяко следващо число е равно на
-- сумата от предходните n числа в потока.
-- Пример: sumLast 3 5 → [3, 3, 6, 12, 24, 48, 93, 183, ... ]


sumLast :: Integer -> Integer -> [Integer]
sumLast k n =
    start n [k]
    where
        generate :: [Integer] -> [Integer]
        generate memory =
            -- newElement : generate (newElement : init memory)
            newElement : generate (tail memory ++ [newElement])
            where
                newElement = sum memory

        start :: Integer -> [Integer] -> [Integer]
        start i memory =
            newElement : start (i-1) (memory ++ [newElement])
            where
                newElement = sum memory
