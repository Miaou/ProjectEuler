module MainEBINaif where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func (prod_triplet . get_triplet) lim


get_triplet lim = [(a, b, c) | a <- [1..(div lim 2)], b <- [a..(div lim 2)], c <- [lim - a - b], a^2 + b^2 == c^2]
prod_triplet [(a, b, c)] = a * b * c
prod_triplet []          = error "No triplet found"
prod_triplet _           = error "More than one triplet found"

