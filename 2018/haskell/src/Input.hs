module Input (inputFor) where

import           Data.Text    (Text)
import           Data.Text.IO (readFile)
import           Prelude      hiding (readFile)

inputFor :: String -> IO Text
inputFor day = readFile $ "./../input/" <> day <>".txt"
