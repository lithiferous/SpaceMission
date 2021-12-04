alias SpaceMission.{Computer, Planets, Trips}

planets = [
  %{
    name: "earth",
    gravity: 9.807
  },
  %{
    name: "moon",
    gravity: 1.62
  },
  %{
    name: "mars",
    gravity: 3.711
  }
]

_planets = planets |> Enum.map(fn p -> Planets.create(p) end)

stages = [
  {:launch, 9.807},
  {:land, 1.62},
  {:launch, 1.62},
  {:land, 9.807}
]

trips = {28801, stages}

fuels = trips |> SpaceMission.compute_fuel()
IO.inspect(fuels)
