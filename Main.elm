-- This is the interface for "elmpreference" - a program that demonstrates
-- preferential voting in Elm!

import Html exposing (text)

-- This will be html and only HTML.


sampleballotvalues =
  [ maybeNumCompare (Just 5) (Just 6)
  , maybeNumCompare (Just 1234) Nothing
  , maybeNumCompare Nothing (Just 6789)
  , maybeNumCompare Nothing Nothing
  ]

sampleballotpaper =
  List.indexedMap (,) [Just 1, Nothing, Just 2, Just 3, Nothing, Just -2]


tupleSwap : (a1, a2) -> (a2, a1)
tupleSwap a =
  (Tuple.second a, Tuple.first a)

swappedballotpaper = List.map tupleSwap sampleballotpaper

maybeNumTupleCompare : (Maybe Int, Int) -> (Maybe Int, Int) -> Order
maybeNumTupleCompare a b =
   maybeNumCompare (Tuple.first a) (Tuple.first b)



sortedpaper = List.sortWith maybeNumTupleCompare swappedballotpaper


main =
  text (toString (sortedpaper))



{-| The maybeNumCompare function compares two Maybe Ints. Any Nothing is considered "greater" than any
  other integer encounted; otherwise we fallback to normal integral comparison. Counterintuitive as this
  may seem, this is good for "normalising" ballot paper value.
-}


maybeNumCompare : Maybe Int -> Maybe Int -> Order
maybeNumCompare a b =
  if (a == Nothing) && (b == Nothing) then
      EQ

  else if a == Nothing then
      GT

  else if b == Nothing then
      LT

  else
      compare (Maybe.withDefault 0 a) (Maybe.withDefault 0 b)
