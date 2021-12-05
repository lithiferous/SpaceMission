alias SpaceMission.Planets

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

trip = {28801, stages}

fuels = trip |> SpaceMission.compute_fuel()
IO.inspect(fuels)

stages = [
  {:launch, 9.807},
  {:land, 3.711},
  {:launch, 3.711},
  {:land, 9.807}
]

trip = {14606, stages}

fuels = trip |> SpaceMission.compute_fuel()
IO.inspect(fuels)

stages = [
  {:launch, 9.807},
  {:land, 1.62},
  {:launch, 1.62},
  {:land, 3.711},
  {:launch, 3.711},
  {:land, 9.807}
]

trip = {75432, stages}

fuels = trip |> SpaceMission.compute_fuel()
IO.inspect(fuels)
