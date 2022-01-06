import Data.List (subsequences, sortOn, nub)

type Vertex = Int
type Graph = [(Vertex, [Vertex])]

graph =
  [ (1, [2, 3])
  , (2, [3])
  , (3, [4, 5])
  , (4, [])
  , (5, [2, 4, 6])
  , (6, [2])
  ]

vertices :: Graph -> [Vertex]
vertices = map fst

children :: Vertex -> Graph -> [Vertex]
children v g = snd $ head $ filter ((== v) . fst) g

isEdge u v g = u `elem` children v g

parents v g = [u | u <- vertices g, isEdge u v g]

-- Разглеждаме ациклични графи с представяне по ваш избор. “Семейство” наричаме
-- множество от възли F такова, че за всеки възел u ∈ F е вярно,
-- че във F са всичките му деца и нито един негов родител или всичките му родители и нито едно негово дете.
-- а) (6 т.) Да се реализира функция isFamily, която проверява дали дадено множество от възли е семейство в даден граф;

set `contains` subset = all (`elem` set) subset

a `intersect` b = [x | x <- a, x `elem` b]

isFamily :: Graph -> [Vertex] -> Bool
isFamily g set = all isFromFamily set -- forall [ allChildren | u <- set]
  where isFromFamily u = onlyChildren || onlyParents
                               -- set са всичките му деца и нито един негов родител
          where onlyChildren = set `contains` allChildren && null (set `intersect` allParents)
                               -- всичките му родители и нито едно негово дете
                onlyParents = set `contains` allParents && null (set `intersect` allChildren)
                allChildren = children u g
                allParents = parents u g

minIncluding :: Graph -> Vertex -> [Vertex]
minIncluding g u = head $ sortOn length $ [
    set | set <- subsequences (vertices g),
          isFamily g set,
          u `elem` set
    ]

--- 3. Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).

type Store = String
type Category = String
type Price = Double
-- type Purchase = (Store, Category, Price)
-- getStore (store, _, _) = store

data Purchase = Purchase
  { store :: Store
  , category :: Category
  , price :: Price
  }

purchase = Purchase
  { store = "LIDL"
  , price = 10.50
  , category = "Dairy"
  }

-- Покупка се означава с наредена тройка от име на магазин (низ),
-- категория (низ) и цена (дробно число). Да се реализира функция,
-- която по даден списък от покупки връща списък от тройки, съдържащи
-- категория,
-- обща цена на покупките в тази категория и
-- името на магазина, в който общата цена на покупките в тази категория е максимална.
-- Всяка категория да се среща в точно една тройка от резултата.

mostExpensive :: [Purchase] -> [(Category, Price, Store)]
mostExpensive purchases = [(
    c,
    getTotalPrice ((== c) . category),
    mostExpensiveStore c
  ) | c <- categories]
  where categories = nub $ map category purchases
        getTotalPrice predicate = sum $ map price $ filter predicate purchases
        mostExpensiveStore cat = last $ sortOn (totalPriceFor cat) stores
          where stores = nub $ map store purchases
                totalPriceFor cat st = getTotalPrice (\Purchase{category = c, store = s} -> c == cat && s == st)

main = print $ store purchase
