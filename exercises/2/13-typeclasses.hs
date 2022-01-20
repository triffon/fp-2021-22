class Truthy a where
  truthy :: a -> Bool

instance Truthy Int where
  truthy 0 = False
  truthy _ = True

-- instance Truthy Bool where
--   truthy True = True
--   truthy False = False

instance Truthy Bool where
  truthy = id

instance Truthy [a] where
  truthy [] = False
  truthy _ = True

instance Truthy (Maybe a) where
  truthy Nothing = False
  truthy _ = True

ifTruthy :: (Truthy a) => a -> b -> b -> b
ifTruthy testValue yesValue noValue = if truthy testValue then yesValue else noValue
