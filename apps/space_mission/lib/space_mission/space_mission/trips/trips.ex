defmodule SpaceMission.Trips do
  @moduledoc """
  Provides accessor functions to manipulate Space trip abstraction,
  please check ./priv/seeds.exs for usage
  """
  alias SpaceMission.{Repo, Planets, Stages}
  alias SpaceMission.Schemas.Trip
  alias Ecto.Multi
  import Ecto.Query

  # todo:
  # - check path graph

  def changeset(params) do
    %Trip{}
    |> Trip.changeset(params)
  end

  def create({mass, stages}) do
    # Given gravity return planet id from our db as gravity is a fixed measure
    planets = Planets.list()

    Multi.new()
    |> Multi.insert(:trips, changeset(%{mass: mass}))
    |> Multi.run(:stages, fn _, %{trips: trip} ->
      callback =
        Enum.map(stages, fn {type, gravity} ->
          planet_id =
            Enum.find_value(planets, fn p ->
              if p.gravity == gravity, do: p.id
            end)

          Stages.create(%{type: type}, planet_id, trip.id)
        end)

      all = Enum.all?(Enum.map(callback, fn {status, _} -> status == :ok end))

      case all do
        true ->
          {:ok, Enum.map(callback, fn {_, s} -> s end)}

        false ->
          errs = Enum.filter(callback, fn {status, _} -> status == :error end)
          {:error, Enum.map(errs, fn {_, e} -> e end)}
      end
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
