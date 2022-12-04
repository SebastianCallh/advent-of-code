module Day2 where

import Data.Text as T

ints "A" = 1
ints "B" = 2
ints "C" = 3
ints "X" = 1
ints "Y" = 2
ints "Z" = 3

winning 3 = 1
winning n = succ n
losing 1 = 3
losing n = pred n

parseRounds :: T.Text -> [(Int, Int)]
parseRounds contents =
  (\(op:me:[]) -> (ints op, ints me)) <$> splits
  where
    splits = T.splitOn " " <$> T.lines contents

roundScore (op, me)
  | op == me = 3
  | winning op == me = 6
  | otherwise = 0

shapeScore (_, me) = me

score = fmap (\r -> roundScore r + shapeScore r)

strategy (op, me)
  | me == 1 = (op, losing op)
  | me == 2 = (op, op)
  | me == 3 = (op, winning op)

sol1 = sum . score . parseRounds
sol2 = sum . score . fmap strategy . parseRounds
sol input = putStrLn $ mconcat [
    show $ sol1 input,
    " ",
    show $ sol2 input
  ]
