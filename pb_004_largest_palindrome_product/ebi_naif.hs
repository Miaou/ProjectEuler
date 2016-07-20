module MainEBINaif where

import Euler.Utils

main :: IO()
main = do
    lim <- read_int
    stat_func getHighestPal lim


getHighestPal p = let interv = [10^(p-1) .. 10^p - 1] in
                  maximum . filter isPal . map (\(x, y) -> x*y) $ [(x, y) | x <- interv, y <- interv, x <= y]

isPal x = let x_str = show x in (==) x_str (reverse x_str)

