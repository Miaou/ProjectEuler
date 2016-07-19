module MainOpt where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func get_sum lim


get_sum target = sum . takeWhile (< target) $ fib_pair

fib_pair = 0:2:(zipWith (+) fib_pair (map (\x -> 4*x) (tail fib_pair)))

