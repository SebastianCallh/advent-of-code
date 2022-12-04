module Day1 where

import Data.List.Split
import Data.Either
import qualified Data.Text as T
import qualified Data.Text.Read as T

parseInt x = case T.decimal x of
  Right (n, _) -> n
  Left _ -> error "oops"

increases x y = case x < y of
  True  -> 1
  False -> 0

intInput input = fmap parseInt $ T.lines input :: [Int]

sol1 input = sum $ zipWith increases lines (tail lines)
  where
    lines = intInput input

sol2 input = sum $ zipWith f windows (tail windows)
  where
    f x y = increases (sum x) (sum y)
    windows = w lines
    lines = intInput input
    w (x:y:z:[]) = [x,y,z] : []
    w (x:y:z:rest) = [x,y,z] : w (y:z:rest)

sol input = putStrLn $ mconcat [
    show $ sol1 input,
    " ",
    show $ sol2 input
  ]
