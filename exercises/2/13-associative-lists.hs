import qualified Data.Map as Map
import Stack (Stack (..), pushMultiple)

type FacultyNumber = Int
type Name = String
type Grade = Double
type StudentInfo = (Name, Grade)
type Student = (FacultyNumber, StudentInfo)
type Class = [Student]

students :: Class
students = [
    (41111, ("Yordan", 5.75)),
    (42222, ("Ivana", 5.35)),
    (43333, ("Antoniya", 4.65)),
    (44444, ("Atanas", 3.25)),
    (45555, ("Stefan", 4.11)),
    (46666, ("Sofiya", 5.05))
  ]

-- data Maybe a = Nothing | Just a

find :: FacultyNumber -> Class -> Maybe StudentInfo
find _ [] = Nothing
find num ((fn, info):xs) = if num == fn then Just info else find num xs
-- find num (x:xs) = if num == fst x then Just (snd x) else find num xs

getFns :: Class -> [FacultyNumber]
getFns = map fst

aboveAverage :: Class -> (Double, [Name])
aboveAverage students = (classAverage, [name | (_, (name, grade)) <- students, grade > classAverage]) where
  classAverage = sum [grade | (_, (_, grade)) <- students] / fromIntegral (length students)

aboveRest :: Class -> [StudentInfo]
aboveRest students = [(name, studentAverage student) | student@(_, (name, grade)) <- students] where
  studentAverage student = sum [grade | (_, (_, grade)) <- [s | s <- students, s /= student]] / fromIntegral (length students)

type ClassMap = Map.Map FacultyNumber StudentInfo

studentsMap :: ClassMap
studentsMap = Map.fromList students

findStudent :: FacultyNumber -> ClassMap -> Maybe StudentInfo
findStudent = Map.lookup

scholarship :: ClassMap -> [Name] -- grade >= 5.5
scholarship = Map.elems . Map.map fst . Map.filter (\(_, grade) -> grade >= 5.5)
-- scholarship = Map.elems . Map.map fst . Map.filterWithKey (\k (_, grade) -> grade >= 5.5)
-- scholarship xs = Map.elems (Map.map fst (Map.filterWithKey (\k (_, grade) -> grade >= 5.5) xs))
-- scholarship xs = Map.elems $ Map.map fst $ Map.filterWithKey (\k (_, grade) -> grade >= 5.5) xs

-- Graphs, January 20 2022
type Vertex = Char
type Neighbors = [Vertex]
type Graph = [(Vertex, Neighbors)]

graph :: Graph
graph = [
    ('a', ['b', 'e']),
    ('b', ['c', 'd']),
    ('c', ['f']),
    ('d', ['c']),
    ('e', []),
    ('f', [])
  ]

children :: Vertex -> Graph -> Neighbors
children _ [] = error "empty graph"
children v (x:xs) = if v == fst x then snd x else children v xs

stackTest :: Stack Integer
stackTest = Stack 1 (Stack 2 (Stack 3 EmptyStack))

dfs :: Vertex -> Graph -> [Vertex]
dfs _ [] = error "empty graph"
dfs v g@(x:xs) = dfsHelper (Stack v EmptyStack) [] where
  dfsHelper EmptyStack _ = []
  dfsHelper (Stack t rest) visited
    | t `elem` visited = dfsHelper rest visited
    | otherwise = t : dfsHelper (pushMultiple rest (children t g)) (t : visited)
