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
| `tests/` | Suites for the fuel arithmetic and the fleet rules |

Quantities are litres, flows litres per hour and durations minutes.

## Development

```
npm install
npm run live      # serve on http://localhost:3333
npm run debug     # same, with the Elm debugger, on http://localhost:3000
```

Formatting is applied on commit once the hook is installed:

```
pre-commit install
```

## Checks

| Command | Checks |
| --- | --- |
| `npm test` | The test suites under `tests/` |
| `npm run analyse` | Unused code, wildcard imports and other elm-analyse findings |
| `npm run build` | That the deployed `--optimize` build still compiles |
| `pre-commit run --all-files` | That everything is elm-format clean |

Continuous Integration runs all four on every push and pull request, split
into a `lint`, an `analyse` and a `test` job.

## Deployment

```
npm run deploy    # build and publish to GitHub Pages
```
