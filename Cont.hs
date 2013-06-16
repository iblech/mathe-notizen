module Cont where

newtype Cont r a = MkCont { runCont :: (a -> r) -> r }

instance Functor (Cont r) where
    fmap f phi = MkCont $ \k -> runCont phi (k . f)

instance Monad (Cont r) where
    return x = MkCont $ \k -> k x
    phi >>= f = MkCont $ \k -> runCont phi $ \x -> runCont (f x) k

--callCC :: Cont r (r -> Cont r a)
--callCC = MkCont $ \k -> k (

-- Pierce
callCC :: ((a -> Cont r b) -> Cont r a) -> Cont r a
callCC f = MkCont $ \k -> runCont (f (\x -> MkCont $ \l -> k x)) k

lem :: Cont r (Either a (a -> Cont r b))
lem = callCC $ \exit -> return $ Right $ \x -> exit $ Left x

{-
prod :: [Int] -> Cont Int Int
prod [] = return 1
prod (x:xs)
    | x 
-}
