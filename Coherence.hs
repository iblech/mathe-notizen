{-# LANGUAGE ExistentialQuantification #-}
module Main where

import Control.Monad

data Module r v = MkModule
    { zero :: v
    , add  :: v -> v -> v
    , mult :: r -> v -> v
    }

data FinGenModule r v = MkFinGenModule
    { underlyingModule :: Module r v
    , generatingFamily :: [v]
    , coefficients     :: v -> [r]
    }

data CoherentModule r v = MkCoherentModule
    { underlyingFinGenModule :: FinGenModule r v
    , kernel                 :: [v] -> FinGenModule r v
    }

instance (Show v) => Show (FinGenModule r v) where
  show m = "fingen<" ++ show (generatingFamily m) ++ ">"

free :: (Num r) => Int -> FinGenModule r [r]
free n = MkFinGenModule
  { underlyingModule = MkModule
    { zero = replicate n 0
    , add  = liftM2 (+)
    , mult = \a -> map (a *)
    }
  , generatingFamily = map (\i -> replicate i 0 ++ [1] ++ replicate (n-i-1) 0) [0..n-1]
  , coefficients     = id
  }

qq :: CoherentModule Rational Rational
qq = MkCoherentModule
  { underlyingFinGenModule = MkFinGenModule
    { underlyingModule = MkModule
      { zero = 0
      , add  = (+)
      , mult = (*)
      }
    , generatingFamily = [1]
    , coefficients     = (:[])
    }
  , kernel = \xs -> undefined
  }


-- Schon erledigt (nur weniger abstrakt):
-- http://hackage.haskell.org/package/constructive-algebra-0.3.0
