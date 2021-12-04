defmodule SpaceMission.Stages do
  @moduledoc """
  Provides accessor functions to manipulate stage of the space trip abstraction
  """
  alias SpaceMission.Repo
  alias SpaceMission.Schemas.{Planet, Stage, Trip}
  alias Ecto.Changeset
  import Ecto.Query

  def changeset(params, planet_id, trip_id) do
    planet = Repo.get(Planet, planet_id)
    trip = Repo.get(Trip, trip_id)

    %Stage{}
    |> Stage.changeset(params)
    |> Changeset.put_assoc(:planet, planet)
    |> Changeset.put_assoc(:trip, trip)
  end

  def create(params, planet_id, trip_id) do
    changeset(params, planet_id, trip_id)
    |> Repo.insert()
  end

  def delete(id) do
    Stage
    |> Repo.get(id)
    |> Repo.delete()
  end

  def show(id) do
    Stage
    |> Repo.get(id)
    |> Repo.preload([:planet, :trip])
  end

  def list() do
    query =
      from(s in Stage,
        order_by: [asc: s.id],
        preload: [:planet, :trip]
      )

    Repo.all(query)
  end
end
