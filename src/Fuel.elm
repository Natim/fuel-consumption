module Fuel exposing (remaining, used)

{-| Fuel arithmetic, kept out of the views so it can be exercised directly.

Quantities are litres, flows litres per hour and durations minutes.

-}


{-| Fuel burnt over the flight.
-}
used : { a | flightTime : Int, fuelFlow : Int } -> Float
used { flightTime, fuelFlow } =
    toFloat flightTime / 60 * toFloat fuelFlow


{-| Fuel left on board at the end of the flight, negative when the flight does
not fit in the fuel loaded.
-}
remaining : { a | flightTime : Int, fuelFlow : Int, initialFuel : Int } -> Float
remaining flight =
    toFloat flight.initialFuel - used flight
