module Examples where

import GroupX_fnY
import qualified Data.Char

-- Стоп-кодоните са закоментирани
-- https://en.wikipedia.org/wiki/Codon_tables#Standard_DNA_codon_table
standardCoding :: CodingTable
standardCoding =
    map (\(c, n) -> (c, Aminoacid n))
        [ (Codon T T T, 1),    (Codon T C T, 6),    (Codon T A T, 10),    (Codon T G T, 17)
        , (Codon T T C, 1),    (Codon T C C, 6),    (Codon T A C, 10),    (Codon T G C, 17)
        , (Codon T T A, 2),    (Codon T C A, 6) {-, (Codon T A A, !!),    (Codon T G A, !!) -}
        , (Codon T T G, 2),    (Codon T C G, 6), {- (Codon T A G, !!), -} (Codon T G G, 18)

        , (Codon C T T, 2),    (Codon C C T, 7),    (Codon C A T, 11),    (Codon C G T, 19)
        , (Codon C T C, 2),    (Codon C C C, 7),    (Codon C A C, 11),    (Codon C G C, 19)
        , (Codon C T A, 2),    (Codon C C A, 7),    (Codon C A A, 12),    (Codon C G A, 19)
        , (Codon C T G, 2),    (Codon C C G, 7),    (Codon C A G, 12),    (Codon C G G, 19)

        , (Codon A T T, 3),    (Codon A C T, 8),    (Codon A A T, 13),    (Codon A G T,  6)
        , (Codon A T C, 3),    (Codon A C C, 8),    (Codon A A C, 13),    (Codon A G C,  6)
        , (Codon A T A, 3),    (Codon A C A, 8),    (Codon A A A, 14),    (Codon A G A, 19)
        , (Codon A T G, 4),    (Codon A C G, 8),    (Codon A A G, 14),    (Codon A G G, 19)

        , (Codon G T T, 5),    (Codon G C T, 9),    (Codon G A T, 15),    (Codon G G T, 20)
        , (Codon G T C, 5),    (Codon G C C, 9),    (Codon G A C, 15),    (Codon G G C, 20)
        , (Codon G T A, 5),    (Codon G C A, 9),    (Codon G A A, 16),    (Codon G G A, 20)
        , (Codon G T G, 5),    (Codon G C G, 9),    (Codon G A G, 16),    (Codon G G G, 20)
        ]

longCode = GeneticCode [T,A,T,A,C,C,A,A,C,C,T,T,C,A,A,A,A,G,A,C,T,A,G,G,A,G,G,G,T,A,G,C,A,T,T,A,A,T,C,G,T,A,G,C,T,C,G,C,A,G,T,C,A,T,C,G,T,G,T,G,A,C,T,C,G,G,G,C,G,T,A,T,A,G,C,G,A,T,T,A,G,A,C,G,A,G,G,A,G,G,A,A,C,T,G,T,C,G,T,T,T,G,G,T,G,A,G,C,A,G,G,G,C,A,A,T,G,A,A,A,A,C,G,A,C,T,G,A,A,A,A,T,A,T,G,A,C,C,G,A,C,C,C,C,C,G,C,T,G,A,T,G,T,A,G,C,C,C,T,A,A,T,G,A,T,G,A,C,A,C,T,T,G,C,C,A,C,T,G,G,G,G,A,G,C,A,A,G,G,T,C,A,C,C,T,G,A,A,A,G,G,C,G,T,T,T,C,C,T,G,C,A,A,C,C,A,T,G,T,T,T,G,T,G,C,C,A,T,T,G,C,A,T,T,T,A,G,A,T,C,T,C,T,T,A,T,A,A,A,T,G,G,T,T,C,T,G,G,G,T,G,T,C,A,A,G,A,G,C,C,G,C,A,A,G,T,G,G,A,T,G,C,T,G,C,C,T,G,A,T,G,G,C,T,G,C,T,C,A,T,C,C,G,C,A,C,C,C,C,G,G,G,C,C,C,A,A,C,T,G,G,A,A,T,T,A,G,A,G,C,A,A,G,A,T,C,T,C,C,C,T,T,A,T,T,C,T,T,T,A,T,G,C,A,C,T,G,A,A,C,G,T,G,C,G,A,C,C,C,C,A,T,C,A,T,G,G,C,G,T,C,A,C,A,C,T,T,C,T,A,C,C,A,G,T,C,T,A,T,G,C,T,G,A,C,T,A,G,G,C,A,C,A,G,G,T,G,T,C,C,T,T,G,A,C,G,T,G,T,G,A,G,G,A,A,C,T,G,T,A,T,A,G,G,C,C,T,C,C,C,C,A,T,A,A,T,T,T,A,T,T,T,G,G,A,A,A,T,T,C,T,G,T,C,G,C,G,A,G,C,T,C,T,G,T,G,C,C,A,G,C,A,C,C,A,A,G,T,T,A,G,G,C,G,G,A,C,A,A,G,A,C,A,C,C,A,T,T,T,G,T,A,A,C,G,G,C,C,T,C,T,T,T,G,C,C,G,A,C,G,T,C,C,G,A,T,G,G,T,C,G,A,A,T,T,C,G,T,G,T,C,T,G,T,A,T,C,G,C,T,G,G,C,T,G,T,C,A,A,T,A,A,C,G,C,A,T,T,A,T,T,T,G,G,A,T,T,C,A,G,G,G,G,T,A,C,A,G,T,T,C,C,C,C,G,T,C,A,C,A,T,G,T,C,A,G,G,T,T,C,G,C,A,C,T,C,A,A,G,T,T,C]

longCodeDup = GeneticCode [C,C,G,C,G,G,C,G,C,A,G,G,A,A,G,T,C,C,A,C,C,G,A,G,A,G,G,T,A,T,G,T,C,G,C,G,T,T,C,T,T,G,G,A,T,G,C,C,G,T,G,G,G,T,C,G,C,G,T,G,A,A,G,T,A,A,T,G,G,A,A,C,G,C,C,C,T,T,C,C,G,T,T,A,A,A,C,C,G,G,C,T,A,T,T,T,C,G,G,T,T,G,C,G,C,G,T,A,A,G,G,A,C,A,C,A,A,G,G,T,T,C,G,A,C,T,T,C,G,A,G,G,A,A,G,A,T,G,T,A,A,G,T,G,A,G,G,G,T,A,C,A,T,T,C,G,A,A,C,A,C,A,C,A,T,T,G,G,C,G,T,A,C,G,A,C,A,G,T,A,G,T,G,A,C,G,G,T,A,A,G,G,T,A,T,A,G,C,T,C,C,G,A,G,C,C,A,C,T,T,T,A,G,T,G,G,A,A,C,G,C,C,C,T,T,C,C,G,T,T,A,A,A,C,C,G,G,C,T,A,T,T,T,C,G,G,T,T,G,C,G,C,G,T,A,A,G,G,A,C,A,C,A,A,G,G,T,T,C,G,A,C,T,T,C,G,A,G,G,A,A,G,A,T,G,T,G,A,G,A,T,A,A,G,C,G,T,T,G,G,A,T,T,T,C,G,A,G,T,C,C,A,T,G,C,G,C,C,G,G,A,C,T,A,G,A,G,A,A,T,G,T,A,C,G,A,C,G,G,T,A,C,G,G,G,A,G,A,C,A,T,A,T,C,G,T,G,C,A,T,A,G,T,C,C,C,C,T,A,C,C,T,G,T,G,T,A,A,A,G,T,T,A,T,A,C,C,A,C,G,G,C,A,T,C,T,C,G,A,G,G,G,A,T,A,A,A,T,G,G,A,A,T,G,G,G,T,T,C,T,G,T,A,C,T,C,T,G,G,G,G,G,C,A,T,C,G,A,G,A,G,T,A,T,A,G,G,T,A,A,T,T,C,C,T,T,A,T,C,T,A,C,A,G,C,T,C,A,T,T,A,C,T,G,A,C,C,C,A,T,T,T,G,A,C,G,T,T,G,G,C,C,G,C,C,A,T,C,T,A,T,G,G,T,C,T,G,C,G,C,C,G,T,T,C,G,G,T,G,T,A,G,G,A,C,C,G,G,A,C,A,C,A,T,T,G,T,G,G,C,G,T,C,G,T,C,A,G,C,A,T,T,G,T,C,T,T,C,G,G,A,G,G,C,C,C,G,A,G,C,A,G,A,A,T,T,G,T,T,G,A,G]

mediumCode = GeneticCode [A,G,T,C,G,C,A,T,A,A,G,G,A,A,G,G,T,G,T,T,G,A,T,G,C,G,T,G,T,C,T,G,A,C,G,G,C,C,G,C,G,A,C,A,G,C,C,G,C,T,G,A,A,A,C,G,C,C,G,G,T,A,G,T,G,G,C,G,G,T,T,A,C,T,G,A,C,G,A,T,A,C,A,T,A,G,A,T,G,A,T,A,C,C,G,C,T,C,A,A,T,T,A,C,C,G,T,T,T,A,T,T,G,T,C,C,A,G,G,G,T,A,A,C,G,C,G,C,C,T,A,T,A,G,G,G,T,A,T,C,G,A,G,A,T,T,T,A,G,T,A,C,T]

mediumCodeDup = GeneticCode [A,T,A,A,C,C,C,T,C,C,T,T,A,A,T,G,C,A,C,T,A,C,C,A,G,G,T,G,T,C,C,T,T,T,G,A,A,T,G,A,G,T,A,C,G,G,G,G,C,T,A,C,T,C,T,T,T,G,A,C,C,A,G,A,T,T,A,G,A,T,G,A,A,T,G,A,G,T,A,C,G,G,G,G,C,T,A,C,T,C,T,T,T,G,A,C,C,A,G,A,T,T,A,G,A,T,A,G,A,T,A,A,C,C,C,T,C,C,T,T,A,A,T,G,C,A,C,T,A,C,C,A,G,G,T,G,T,C,C,T,T,T,A,G,C,G,G,C,T,G,G,G,G,A,A,C,T,A,T,C,G,G,A,T,A,C,T,T,A,C,G,A,A,G,A,T,G]

shortCode = GeneticCode [C,C,T,G,G,C,A,G,A,G,T,A,C,A,C,T,T,C,T,A,A,G,T,G,A,C,C,T,C,G,A,G,T,T,C,C,G,T,T,T,G,A,G,C,T,G,A,T,A,A,G,A,T,A,T,T,T,A,A,A]

shortCodeDup = GeneticCode [G,A,C,C,T,A,C,A,T,T,T,G,T,A,G,G,A,C,C,T,A,C,A,T,T,T,G,T,A,G,G,A,C,C,T,A,C,A,T,T,T,G,T,A,G,G,A,C,C,T,A,C,A,T,T,T,G]

check :: (Eq a, Show a) => a -> a -> String -> IO ()
check x y descr = do
    if x == y
    then putStrLn $ "🗸 pass: " ++ descr
    else do
        putStrLn $ "✗ fail: " ++ descr
        putStrLn $ "    expected " ++ show x ++ ", actual " ++ show y

testHasSameProteins :: IO ()
testHasSameProteins = do
    putStrLn "testing hasSameProteins"
    check False (hasSameProteins standardCoding (GeneticCode [C, C, C]))  "hasSameProteins standardCoding (GeneticCode [C, C, C])"

    check True (hasSameProteins standardCoding shortCodeDup)  "hasSameProteins standardCoding shortCodeDup"
    check True (hasSameProteins standardCoding mediumCodeDup) "hasSameProteins standardCoding mediumCodeDup"
    check True (hasSameProteins standardCoding longCodeDup)   "hasSameProteins standardCoding longCodeDup"

    check False (hasSameProteins standardCoding shortCode)  "hasSameProteins standardCoding shortCode"
    check False (hasSameProteins standardCoding mediumCode) "hasSameProteins standardCoding mediumCode"
    check False (hasSameProteins standardCoding longCode)   "hasSameProteins standardCoding longCode"

testMaxMutations :: IO ()
testMaxMutations = do
    putStrLn "testing maxMutations"

    check 1 (maxMutations standardCoding (GeneticCode [T, A, A]))  "maxMutations standardCoding (GeneticCode [T, A, A])"
    check 2 (maxMutations standardCoding (GeneticCode [T, A, G]))  "maxMutations standardCoding (GeneticCode [T, A, G])"
    check 1 (maxMutations standardCoding (GeneticCode [C, C, C]))  "maxMutations standardCoding (GeneticCode [C, C, C])"

    check 30  (maxMutations standardCoding shortCodeDup)  "maxMutations standardCoding shortCodeDup"
    check 82  (maxMutations standardCoding mediumCodeDup) "maxMutations standardCoding mediumCodeDup"
    check 275 (maxMutations standardCoding longCodeDup)   "maxMutations standardCoding longCodeDup"

    check 28  (maxMutations standardCoding shortCode)  "maxMutations standardCoding shortCode"
    check 77  (maxMutations standardCoding mediumCode) "maxMutations standardCoding mediumCode"
    check 288 (maxMutations standardCoding longCode)   "maxMutations standardCoding longCode"

main :: IO ()
main = do
    testHasSameProteins
    testMaxMutations
