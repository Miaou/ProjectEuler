module EbiNaif where

import System.Environment   -- getArgs
import Text.Printf
import System.IO            -- stderr
import System.CPUTime
import Data.List
import Data.List.Split

main :: IO()
main = do
    args <- getArgs
    if length args /= 2
      then echo_err "There shall be exactly two arguments (first, the input file, then the number of digits)."
      else let input_file_name = args !! 0 :: String ;
               nb_digits = read $ args !! 1 :: Int in do
        (t,v) <- time getLargestProduct input_file_name nb_digits
        printf "Input  : %d\n" nb_digits
        printf "Result : %d\n" (v::Int)
        printf "Time   : %.3fs\n" (t::Float)

echo_err str = hPutStrLn stderr str 

-- See https://wiki.haskell.org/Timing_computations for better time computations
time f x y = do
    start <- getCPUTime
    x <- f x y
    end <- getCPUTime
    return ((fromIntegral (end-start))*1e-12, x)

getLargestProduct file_name nb_digits = do
        content <- readFile file_name
        let arrays = concat . map (sublist nb_digits) . splitOn "0" . filter (\x -> x /= '\n') $ content in do
            return . maximum . map listproduct $ arrays

listproduct list = product . map ((\x y -> read [(x!!y)] :: Int) list) $ [0 .. length list - 1]
sublist len list = map (\x -> take len . drop x $ list) [0 .. length list - len]

