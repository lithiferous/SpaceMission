alias SpaceMission.{Planets, Trips}

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

planets = Enum.map(planets, fn p -> Planets.create(p) end)

stages = [
  {:launch, 9.807},
  {:land, 1.62},
  {:launch, 1.62},
  {:land, 9.807}
]

trips = [
  {28801,
   [
     {:launch, 9.807},
     {:land, 1.62},
     {:launch, 1.62},
     {:land, 9.807}
   ]}
]

trips =
  Enum.map(trips, fn t ->
    Trips.create(t)
  end)

IO.inspect(trips)

IO.inspect(Trips.list())

#    SpaceMission.load_stages(stages)
#    |> Enum.map(fn schema ->
#      IO.inspect(%{mass: mass, stage_id: schema.id})
#
#      SpaceMission.create_trip(
#        %{mass: mass},
#        schema.id
#      )
#    end)
#  end)

#
# ass = IO.inspect(trips)
