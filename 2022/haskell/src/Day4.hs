module Day4 where

import Data.Either
import qualified Data.Text as T
import qualified Data.Text.Read as T

parse line = ((int from1, int to1), (int from2, int to2))
  where
    [from1, to1] = T.splitOn "-" elf1
    [from2, to2] = T.splitOn "-" elf2
    [elf1, elf2] = T.splitOn "," line
    int = fromRight 0 . fmap fst . T.decimal

subsets ((min1, max1), (min2, max2)) =
  (min1 <= min2 && max2 <= max1) ||
  (min2 <= min1 && max1 <= max2)

overlaps ((min1, max1), (min2, max2)) =
  (min1 <= min2 && min2 <= max1) ||
  (min2 <= min1 && min1 <= max2) ||
  (min1 <= max2 && max2 <= max1) ||
  (min2 <= max1 && max1 <= max2)

toint True = 1
toint False = 0

sol1 = sum . fmap (toint . subsets . parse) . T.lines
sol2 = sum . fmap (toint . overlaps . parse) . T.lines
sol input = putStrLn $ mconcat [
    show $ sol1 input,
    " ",
    show $ sol2 input
  ]
