module Day2 where
import qualified Data.Text as T
import qualified Data.Text.Read as T
import Data.List

data Op
  = Forward Int
  | Up Int
  | Down Int

parseOp line = case T.splitOn " " line of
  ["forward", n] -> Forward (parseInt n)
  ["up", n]      -> Up      (parseInt n)
  ["down", n]    -> Down    (parseInt n)

run1 (x, y) op = case op of
  (Forward n) -> (x + n, y)
  (Up      n) -> (x, y - n)
  (Down    n) -> (x, y + n)

run2 (x, y, a) op = case op of
  (Forward n) -> (x + n, y + n * a, a)
  (Up      n) -> (x, y, a - n)
  (Down    n) -> (x, y, a + n)

parseInt x = case T.decimal x of
  Right (n, _) -> n
  Left _       -> error "oops"

sol1 = uncurry (*) . foldl run1 (0, 0) . fmap parseOp . T.lines
sol2 = (\(x, y, a) -> x*y) . foldl run2 (0, 0, 0) . fmap parseOp . T.lines

sol input = putStrLn $ mconcat [
    show $ sol1 input,
    " ",
    show $ sol2 input
  ]
