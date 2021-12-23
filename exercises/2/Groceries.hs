module Groceries (
  getStore,
  getCategory,
  getPrice,
  Grocery
) where

type Grocery = (String, String, Double)

getStore :: Grocery -> String
getStore (store, _, _) = store

getCategory :: Grocery -> String
getCategory (_, category, _) = category

getPrice :: Grocery -> Double
getPrice (_, _, price) = price
