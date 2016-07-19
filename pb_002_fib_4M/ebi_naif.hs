module MainEBINaif where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func get_sum lim


get_sum target = sum . filter even . takeWhile (< target) $ fib

fib = 0:1:(zipWith (+) fib (tail fib))

