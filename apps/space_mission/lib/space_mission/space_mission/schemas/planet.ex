defmodule SpaceMission.Schemas.Planet do
  alias SpaceMission.Schemas.Stage
  import Ecto.Changeset
  use Ecto.Schema

  schema "planets" do
    field(:name, :string)
    field(:gravity, :float)
    has_many(:stages, Stage)
  end

  def changeset(planet, params \\ %{}) do
    planet
    |> cast(params, [:name, :gravity])
    |> validate_required([:name, :gravity])
    |> validate_inclusion(:name, ["earth", "mars", "moon"])
    |> validate_number(:gravity, greater_than: 0)
  end
end
