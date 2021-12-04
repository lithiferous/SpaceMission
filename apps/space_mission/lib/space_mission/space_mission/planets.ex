defmodule SpaceMission.Planets do
  @moduledoc """
  Provides accessor functions to manipulate Planet trip abstraction
  """
  alias SpaceMission.Repo
  alias SpaceMission.Schemas.Planet
  import Ecto.Query

  def changeset(params) do
    %Planet{}
    |> Planet.changeset(params)
  end

  def create(params) do
    changeset(params)
    |> Repo.insert()
  end

  def delete(id) do
    Planet
    |> Repo.get(id)
    |> Repo.delete()
  end

  def list() do
    query =
      from(p in Planet,
        order_by: [desc: p.gravity]
      )

    Repo.all(query)
  end

  def get_by(attrs) do
    list()
    |> Enum.find(fn planet ->
      Map.keys(attrs)
      |> Enum.all?(fn key ->
        planet
        |> Map.get(key) === attrs[key]
      end)
    end)
  end

  def get(id) do
    Planet |> Repo.get(id)
  end
end
