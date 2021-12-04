defmodule SpaceMission do
  alias SpaceMission.Schemas.Trip
  alias SpaceMission.{Computer, Trips}

  def compute_fuel({mass, stages}) do
    {_, commit} = Trips.create({mass, stages})

    trip =
      commit
      |> Map.get(:trips)

    trip = Trips.get(Trip, trip.id)

    trip.stages
    |> Enum.map(fn stage ->
      Computer.compute_mass_of_fuel_for_mass(
        trip.mass,
        stage.type,
        stage.planet.gravity
      )
    end)
    |> Enum.sum()
  end
end
