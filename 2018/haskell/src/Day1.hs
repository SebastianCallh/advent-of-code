module Day1 where

import qualified Data.Text as T
import qualified Data.IntSet          as S
import           Data.List            (unfoldr)
import           Data.Void            (Void)
import           Text.Megaparsec
import           Text.Megaparsec.Char
import Input (inputFor)

type Parser = Parsec Void T.Text

answer1 = do
  eDigits <- readDigits
  pure $ sum <$> eDigits

answer2 = do
  digits <- readDigits
  pure $ solve S.empty 0 . cycle <$> digits
  where
    solve seen freq (x:xs)
      | freq `S.member` seen = freq
      | otherwise            = solve (S.insert freq seen) (freq + x) xs

readDigits = do
  input <- T.lines <$> inputFor "Day1"
  pure $ traverse (parse digit "") input

digit :: Parser Int
digit = choice [negativeDigit, positiveDigit]

negativeDigit :: Parser Int
negativeDigit = char '-' *> ((*(-1)). read <$> some digitChar)

positiveDigit :: Parser Int
positiveDigit = char '+' *> (read <$> some digitChar)



