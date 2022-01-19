module Palindrome where

import Control.Monad

main = do putStrLn "Моля, въведете палиндром: "
          line <- getLine
          let revLine = reverse line
          if revLine == line then putStrLn "Благодаря!"
          else do putStrLn $ line ++ " не е палиндром!"
--                  main
