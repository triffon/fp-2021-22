import Data.Maybe (fromMaybe, fromJust)
import Data.Char (ord)
import Tree

data Someone = Me | You deriving (Show)

whoAmI :: String -> Someone
whoAmI "Tommy" = Me
whoAmI _ = You

data Car = Car {
  getMake :: String,
  getModel :: String,
  getYear :: Int
}
instance Show Car where
  show (Car make model year) = "This is a " ++ make ++ " " ++ model ++ " from " ++ show year

car :: Car
car = Car "Volkswagen" "Golf" 2019

-- getMake :: Car -> String
-- getMake (Car make _ _) = make

-- getModel :: Car -> String
-- getModel (Car _ model _) = model

-- getYear :: Car -> Int
-- getYear (Car _ _ year) = year

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
  deriving (Show, Read, Eq, Ord, Enum, Bounded)

today :: Day
today = Thursday

tomorrow :: Day
tomorrow = succ today

yesterday :: Day
yesterday = pred today

week :: [Day]
week = [Monday .. Sunday]

sunday :: Day
sunday = read "Sunday" :: Day

lastDayOfWeek :: Day
lastDayOfWeek = maxBound :: Day

-- data Maybe a = Just a | Nothing
find :: (a -> Bool) -> [a] -> Maybe a
find _ [] = Nothing
find p (x:xs) = if p x then Just x else find p xs

-- getActualDay :: (Day -> Bool) -> [Day] -> Day
-- getActualDay p days = case find p days of
--   Nothing -> Monday
--   Just d -> d

getActualDay :: (Day -> Bool) -> [Day] -> Day
getActualDay p days = fromMaybe Monday $ find p days

tree :: Tree Char
tree = TreeNode 'a'
        (TreeNode 'b'
          EmptyTree
          (TreeNode 'd' EmptyTree EmptyTree))
        (TreeNode 'c'
          (TreeNode 'f' EmptyTree EmptyTree)
          (TreeNode 'e' EmptyTree EmptyTree))

bst :: Tree Int
bst = TreeNode 20
        (TreeNode 10
          (TreeNode 0
            (TreeNode (-5) EmptyTree EmptyTree)
            (TreeNode 5
              (TreeNode 2 EmptyTree EmptyTree)
              EmptyTree))
            (TreeNode 15
              EmptyTree
              (TreeNode 16 EmptyTree EmptyTree)))
        (TreeNode 27
          (TreeNode 25 EmptyTree EmptyTree)
          (TreeNode 35
            (TreeNode 30 EmptyTree EmptyTree)
            EmptyTree))
