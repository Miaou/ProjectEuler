module MainEBISolution where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func get_sum_3_5 lim


get_sum_3_5 :: (Integral a) => a -> a
get_sum_3_5 target = (get_sum target 3) + (get_sum target 5) - (get_sum target 15)

-- SUM(x, 1, N) = N * (N + 1) / 2
get_sum :: (Integral a) => a -> a -> a
get_sum target multiple = let higher_bound = div (target - 1) multiple
                          in multiple * higher_bound * (higher_bound + 1) `div` 2

