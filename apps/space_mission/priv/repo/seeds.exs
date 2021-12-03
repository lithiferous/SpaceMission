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

planets = planets |> Enum.map(fn p -> Planets.create(p) end)

stages = [
  {:launch, 9.807},
  {:land, 1.62},
  {:launch, 1.62},
  {:land, 9.807}
]

trips = [
  {28801, stages}
]

trips = trips |> Enum.map(fn t -> Trips.create(t) end)

trips = Trips.list()

fuels =
  trips
  |> Enum.map(fn t ->
    t.stages
    |> Enum.map(fn s ->
      Computer.compute_mass_of_fuel_for_mass(s.type, t.mass, s.planet.gravity)
    end)
  end)

IO.inspect(fuels)
