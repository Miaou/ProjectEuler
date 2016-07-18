module EbiNaif where

import Data.List
import Data.List.Split
import Euler.Utils
import Text.Printf (printf)

main :: IO()
main = do
    (input_file_name, nb_digits) <- read_string_int
    (t,v) <- time_3args getLargestProduct input_file_name nb_digits
    printf "Input  : %d\n" nb_digits
    printf "Result : %d\n" (v::Int)
    printf "Time   : %.3fs\n" (t::Float)

getLargestProduct file_name nb_digits = do
        content <- readFile file_name
        let arrays = concat . map (sublist nb_digits) . splitOn "0" . filter (\x -> x /= '\n') $ content in do
            return . maximum . map listproduct $ arrays

listproduct list = product . map ((\x y -> read [(x!!y)] :: Int) list) $ [0 .. length list - 1]
sublist len list = map (\x -> take len . drop x $ list) [0 .. length list - len]

