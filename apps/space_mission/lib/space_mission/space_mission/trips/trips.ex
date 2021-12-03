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
    planets = Planets.list()

    Multi.new()
    |> Multi.insert(:trips, changeset(%{mass: mass}))
    |> Multi.run(:stages, fn _, %{trips: trip} ->
      callback =
        stages |> Enum.map(fn {type, gravity} ->
    # Given gravity return planet id from our db as gravity is a fixed measure
          planet_id =
            planets |> Enum.find_value(fn p ->
              if p.gravity == gravity, do: p.id
            end)

          Stages.create(%{type: type}, planet_id, trip.id)
        end)

      all = Enum.all?(Enum.map(callback, fn {status, _} -> status == :ok end))

      case all do
        true ->
          {:ok, callback |> Enum.map(fn {_, s} -> s end)}

        false ->
          errs = callback |> Enum.filter(fn {status, _} -> status == :error end)
          {:error, errs |> Enum.map(fn {_, e} -> e end)}
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
