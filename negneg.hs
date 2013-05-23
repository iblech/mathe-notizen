module Main where

f :: ((Either (a -> r) ((a -> r) -> r)) -> r) -> r
f alpha = alpha $ Left beta where
    beta x = alpha $ Right ($ x)
