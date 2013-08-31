module Main where

import Control.Monad
import Text.Printf

base = (0,0,0)

plane = ((1,0,0),-1)

points = concat
    [ [ (t, t^2, -5) | t <- ts ]
    , [ (t, 5, -5)   | t <- ts ]
    , [ (t, 3, -5)   | t <- ts ]
    , [ (t, 3+t, -5)   | t <- ts ]
    ]
    where
    ts = [0, 0.01 .. 20]

infixl 6 <+>
infixl 7 .*
infixl 7 <*>
(<+>) (x1,y1,z1) (x2,y2,z2) = (x1+x2, y1+y2, z1+z2)
(<*>) (x1,y1,z1) (x2,y2,z2) = x1*x2 + y1*y2 + z1*z2
(.*)  a (x,y,z) = (a*x, a*y, a*z)

intersection p q (n,d) = if n <*> v /= 0 then Just (p <+> lambda .* v) else Nothing
    where
    lambda = (-d - n <*> p) / (n <*> v)
    v      = q <+> (-1) .* p

main = do
    forM_ points $ \p -> do
        case intersection base p plane of
            Just (_,x,y) -> printf "%f\t%f\n" (fromRational x::Double) (fromRational y::Double)
            Nothing      -> return ()
