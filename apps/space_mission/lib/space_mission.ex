defmodule SpaceMission do
  alias SpaceMission.Schemas.Trip
  alias SpaceMission.{Computer, Trips}

  def compute_fuel({mass, stages}) do
    {_, commit} = Trips.create({mass, stages})

    trip =
      commit
      |> Map.get(:trips)

    trip = Trips.get(Trip, trip.id)

    fuels =
      trip.stages
      |> Enum.map(fn stage ->
        Computer.compute_fuel_mass(
          trip.mass,
          stage.type,
          stage.planet.gravity
        )
      end)

    IO.inspect(fuels)

    fuels |> Enum.sum()
  end
end
