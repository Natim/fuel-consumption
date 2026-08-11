# Fuel Consumption

A widget that allow you to compute your fuel consumption

## Layout

| Module | Role |
| --- | --- |
| `src/FuelConsumption.elm` | Model, init, update and the top level view |
| `src/Fuel.elm` | Fuel arithmetic, free of any view concern |
| `src/Plane.elm` | The club fleet and the rules attached to a plane |
| `src/Msg.elm` | Messages, kept apart so the views can build them |
| `src/Views/` | Rendering only, each view declaring the fields it reads |

Quantities are litres, flows litres per hour and durations minutes.

## Development

```
npm install
npm run live     # serve on http://localhost:3333
npm test
npm run analyse
npm run build
```
