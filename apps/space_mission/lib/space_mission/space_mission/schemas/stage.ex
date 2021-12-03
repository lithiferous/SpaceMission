defmodule SpaceMission.Schemas.Stage do
  alias SpaceMission.Schemas.{Planet, Trip}
  import Ecto.Changeset
  use Ecto.Schema

  schema "stages" do
    field(:type, Ecto.Enum, values: [:land, :launch])
    belongs_to(:planet, Planet)
    belongs_to(:trip, Trip)
    timestamps()
  end

  def changeset(stage, params \\ %{}) do
    stage
    |> cast(params, [:type])
  end
end
