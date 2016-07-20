module MainEBINaif where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func get_diff lim


get_diff target = let array = [1 .. target] in (sum array)^2 - (sum $ zipWith (*) array array)

