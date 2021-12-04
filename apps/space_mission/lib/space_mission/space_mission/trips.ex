defmodule SpaceMission.Trips do
  @moduledoc """
  Provides accessor functions to manipulate Space trip abstraction,
  please check ./priv/seeds.exs for usage
  """
  alias SpaceMission.{Repo, Planets, Stages}
  alias SpaceMission.Schemas.Trip
  alias Ecto.Multi
  import Ecto.Query

  def changeset(params) do
    %Trip{}
    |> Trip.changeset(params)
  end

  def create({mass, stages}) do
    Multi.new()
    |> Multi.insert(:trips, changeset(%{mass: mass}))
    |> Multi.run(:stages, fn _, %{trips: trip} ->
      callback =
        stages
        |> Enum.map(fn {type, gravity} ->
          # Given gravity return planet id from our db as gravity is a fixed measure
          planet = Planets.get_by(%{gravity: gravity})
          Stages.create(%{type: type}, planet.id, trip.id)
        end)

      {:ok, callback |> Enum.map(fn {_, s} -> s end)}
    end)
    |> Repo.transaction()
  end

  def show(id) do
    Trip
    |> Repo.get(id)
  end

  def list() do
    query =
      from(t in Trip,
        order_by: [desc: t.id],
        preload: [stages: :planet]
      )

    Repo.all(query)
  end
end
