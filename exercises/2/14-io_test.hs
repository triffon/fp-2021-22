import Data.Char (isPunctuation)

main :: IO ()
main = do
  line <- getLine

  if line == ":q"
    then return ()
    else do
      let punctuation = filter isPunctuation line
          exclamation = [p | p <- punctuation, p == '!']
      putStrLn punctuation
      putStrLn exclamation
      main
