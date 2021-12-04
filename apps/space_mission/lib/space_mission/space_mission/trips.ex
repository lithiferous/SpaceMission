defmodule SpaceMission.Trips do
  @moduledoc """
  Provides accessor functions to manipulate Space trip abstraction,
  please check ./priv/seeds.exs for usage
  """
  alias SpaceMission.{Repo, PathFinder, Planets, Stages}
  alias SpaceMission.Schemas.Trip
  alias Ecto.Multi
  import Ecto.Query

  def changeset(params) do
    %Trip{}
    |> Trip.changeset(params)
  end

  @doc """
  Upon creating a unique trip entry we check for two things: 1) the destination planet exists in our database. (We initialize the planet entity within seeds.ex before making any commits). 2) Path is supposed to be possible within our universe: e.g. we can't land on moon and launch from mars, or we can't launch from earth followed by launch from moon.
  """
  def create({mass, stages}) do
    Multi.new()
    |> Multi.insert(:trips, changeset(%{mass: mass}))
    |> Multi.run(:stages, fn _, %{trips: trip} ->
      stages =
        stages
        |> Enum.map(fn {type, gravity} ->
          # Given gravity return planet id from our db as gravity is a fixed measure
          planet = Planets.get_by(%{gravity: gravity})
          Stages.create(%{type: type}, planet.id, trip.id)
        end)
        |> Enum.map(fn {_, s} -> s end)

      # traverse path graph for inconsistencies
      {status, message} = PathFinder.path_valid?(stages)

      case status do
        :error -> Repo.rollback({:error, message})
        :ok -> {:ok, stages}
      end
    end)
    |> Repo.transaction()
  end

  def get(Trip, id) do
    Trip
    |> Repo.get(id)
    |> Repo.preload(stages: :planet)
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
