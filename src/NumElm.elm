module NumElm exposing (..)

{-| The NumPy for Elm

# Types
@docs NdArray, Shape, Dtype


# Creating NdArray
@docs ndarray, cube, matrix, vector


# Getting NdArray properties
@docs shape, size, dtype


# Prepopulated matrixes
@docs zeros, ones, identity, eye
-}

import Native.NumElm
import List exposing (..)
import Maybe exposing (..)


{-| Represents a multidimensional,
homogeneous array of fixed-size items
-}
type NdArray
    = NdArray


{-| List of dimensions dimensions.

  [3, 4]        == 3x4 matrix
  [2] == [2, 1] == 2x1 column vector
  [1, 4]        == 1x4 row vector
  [3, 2, 5]     == 3x2x5 matrix (3D )

-}
type alias Shape =
    List Int


{-| Data type of the ndarray.
-}
type Dtype
    = Int8
    | In16
    | Int32
    | Float32
    | Float64
    | Uint8
    | Uint16
    | Uint32


{-| Creates an NdArray from a list of numbers

    ndarray [1, 2, 3, 4, 5, 6] [3, 2] Int8

    Creates a matrix 3x2 of 8-bit signed integers.
    [
      [1, 2],
      [3, 4],
      [5, 6]
    ]

-}
ndarray : List number -> Shape -> Dtype -> NdArray
ndarray list shape dtype =
    NdArray


{-| Creates an NdArray from a 3D list

    matrix [ [ [1, 2]
             , [3, 4]
             ]
           , [ [5, 6]
             , [7, 8]
             ]
           , [ [9, 10]
             , [11, 12]
             ]
           ] Float64

    Creates a 3D matrix 3x2x2 of of 64-bit floating point numbers.

-}
cube : List (List (List number)) -> Dtype -> NdArray
cube list dtype =
    let
        maybeYList =
            head list

        firstYList =
            case maybeYList of
                Just yList ->
                    yList

                Nothing ->
                    []

        maybeZList =
            head firstYList

        firstZList =
            case maybeZList of
                Just zList ->
                    zList

                Nothing ->
                    []

        d1 =
            length list

        d2 =
            length firstYList

        d3 =
            length firstZList
    in
        ndarray
            (List.concatMap
                (\sublist ->
                    List.concatMap
                        (\a -> a)
                        sublist
                )
                list
            )
            [ d1, d2, d3 ]
            dtype


{-| Creates an NdArray from a 2D list

    matrix [ [1, 2, 3]
           , [4, 5, 6]
           ] Float32

    Creates a matrix 2x3 of of 32-bit floating point numbers.
    [
      [1, 2, 3],
      [4, 5, 6]
    ]

-}
matrix : List (List number) -> Dtype -> NdArray
matrix list dtype =
    let
        maybeYList =
            head list

        d1 =
            length list

        d2 =
            case maybeYList of
                Just firstYList ->
                    length firstYList

                Nothing ->
                    0
    in
        ndarray (List.concatMap (\a -> a) list) [ d1, d2 ] dtype


{-| Creates an NdArray from a 1D list

    vector [ 1, 2, 3, 4, 5, 6 ] Int16

    Creates a column vector 6x1 of 16-bit signed integers.
    [ 1
    , 2
    , 3
    , 4
    , 5
    , 6
    ]

-}
vector : List number -> Dtype -> NdArray
vector list dtype =
    let
        d1 =
            length list
    in
        ndarray list [ d1 ] dtype


{-| Returns the shape of the ndarray.
-}
shape : NdArray -> Shape
shape ndarray =
    []


{-| Alias for shape.
-}
size : NdArray -> Shape
size ndarray =
    shape ndarray


{-| Returns the data type of the ndarray.
-}
dtype : NdArray -> Dtype
dtype ndarray =
    Float64


{-| Return a new ndarray of given shape and type, filled with zeros.
-}
zeros : Shape -> Dtype -> NdArray
zeros shape dtype =
    NdArray


{-| Return a new ndarray of given shape and type, filled with ones.
-}
ones : Shape -> Dtype -> NdArray
ones shape dtype =
    NdArray


{-| Return an identity matrix of given [size, size] shape and type.
-}
identity : Int -> Dtype -> NdArray
identity size dtype =
    NdArray


{-| Alias for identity.
-}
eye : Int -> Dtype -> NdArray
eye size dtype =
    identity size dtype
