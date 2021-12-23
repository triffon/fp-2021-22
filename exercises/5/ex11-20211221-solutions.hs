import Data.List (nub)

-- Зад.2
-- Това е Data.List.subsequences :)
subsets :: [a] -> [[a]]
subsets [] = [[]]
subsets (x:xs) = rest ++ map (x:) rest -- [ x:s | s<-rest ]
  where rest = subsets xs

-- Зад.3
addAssoc :: (Eq a, Eq b) => a -> b -> [(a,[b])] -> [(a,[b])]
addAssoc k v [] = [(k,[v])]                            -- yo dawg, we heard you like pattern matching
addAssoc k v lst@(p@(k1,v1):ps)                        -- so we put pattern matches inside your pattern matches
  | k == k1 && v `elem` v1 = lst
  | k == k1                = (k1,v:v1) : ps
  | otherwise              = p : addAssoc k v ps


e :: [(Int, Int)]
e = [(0,1),(0,2),(1,2),(2,3),(1,3)]
-- Зад.4
edgesToNeighbs :: Eq a => [(a,a)] -> [(a,[a])]
edgesToNeighbs edges =
  foldr (\(k,v) res -> addAssoc k v res)
        [ (u,[]) | u<-allVertices ]
        edges
  where allVertices = nub $ (map fst edges) ++ (map snd edges)
