module MainEBINaif where

import Data.List.Split
import Euler.Utils

main :: IO()
main = do
    (filename, nb_digits) <- read_string_int
    file_content <- readFile filename
    stat_func getLargestProduct (file_content, nb_digits)

getLargestProduct (file_content, nb_digits) =
        maximum . map listproduct . concat . map (sublist nb_digits) . splitOn "0" . concat . lines $ file_content

listproduct list = product . map ((\x y -> read [(x!!y)] :: Int) list) $ [0 .. length list - 1]

sublist len list = map (\x -> take len . drop x $ list) [0 .. length list - len]

