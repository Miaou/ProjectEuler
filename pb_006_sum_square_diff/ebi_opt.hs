module MainEBIOpt where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func get_diff lim


get_diff x = div (x * (x+1) * (3*x^2 - x - 2)) 12

