module FuelTest exposing (suite)

import Expect
import Fuel
import Fuzz
import Plane
import Test exposing (Test, describe, fuzz2, test)


closeTo : Float -> Float -> Expect.Expectation
closeTo expected actual =
    Expect.within (Expect.Absolute 1.0e-6) expected actual


suite : Test
suite =
    describe "Fuel"
        [ describe "used"
            [ test "burns a fraction of the hourly flow over a partial hour" <|
                \_ ->
                    Fuel.used { flightTime = 45, fuelFlow = 15 }
                        |> closeTo 11.25
            , test "burns exactly the hourly flow over an hour" <|
                \_ ->
                    Fuel.used { flightTime = 60, fuelFlow = 40 }
                        |> closeTo 40
            , test "burns nothing on the ground" <|
                \_ ->
                    Fuel.used { flightTime = 0, fuelFlow = 15 }
                        |> closeTo 0
            ]
        , describe "remaining"
            [ test "subtracts what was burnt from what was loaded" <|
                \_ ->
                    Fuel.remaining { flightTime = 45, fuelFlow = 15, initialFuel = 110 }
                        |> closeTo 98.75
            , test "goes negative when the flight does not fit in the fuel loaded" <|
                \_ ->
                    Fuel.remaining { flightTime = 60, fuelFlow = 15, initialFuel = 10 }
                        |> closeTo -5
            , fuzz2 (Fuzz.intRange 0 600) (Fuzz.intRange 0 100) "always accounts for every litre loaded" <|
                \flightTime fuelFlow ->
                    let
                        flight =
                            { flightTime = flightTime, fuelFlow = fuelFlow, initialFuel = 100 }
                    in
                    Fuel.remaining flight
                        + Fuel.used flight
                        |> closeTo 100
            ]
        , describe "Plane.fromRegistration"
            [ test "finds a plane of the fleet" <|
                \_ ->
                    Plane.fromRegistration "F-GHYZ"
                        |> Maybe.map .type_
                        |> Expect.equal (Just "PA28")
            , test "finds nothing for a registration outside the fleet" <|
                \_ ->
                    Plane.fromRegistration "F-ZZZZ"
                        |> Expect.equal Nothing
            , test "finds every plane of the fleet by its own registration" <|
                \_ ->
                    Plane.all
                        |> List.map (.registration >> Plane.fromRegistration)
                        |> Expect.equal (List.map Just Plane.all)
            ]
        ]
