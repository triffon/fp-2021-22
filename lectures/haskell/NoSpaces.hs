module Main where

main = noSpacesv2

noSpaces = do text <- getContents
              putStr $ filter (/=' ') text

noSpacesv2 = interact $ filter (/= ' ')

