module MainPABNaif where

import Euler.Utils
import Data.Int (Int64)

main :: IO()
main = do
    prod <- read_integer
    if abs prod < truncate (2**63-1)
    then stat_func (last . decomp) (fromIntegral prod :: Int64)
    else stat_func (last . decomp) prod




decomp :: (Integral a) => a -> [a]
decomp prod
    | prod > 1  = let divider n d = n `mod` d == 0
                      numbers = takeWhile (<= (truncate $ (fromIntegral prod)**0.5)) (2:[3,5..])
                      div1 = head $ filter (divider prod) (numbers ++ [prod])
                  in div1 : decomp (prod `div` div1)
    | otherwise = []

