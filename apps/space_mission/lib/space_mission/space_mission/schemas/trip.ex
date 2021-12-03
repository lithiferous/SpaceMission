defmodule SpaceMission.Schemas.Trip do
  alias SpaceMission.Schemas.Stage
  import Ecto.Changeset
  use Ecto.Schema

  schema "trips" do
    field(:mass, :integer)
    has_many(:stage, Stage)
    timestamps()
  end

  def changeset(trip, params \\ %{}) do
    trip
    |> cast(params, [:mass, :updated_at])
    |> validate_change(:updated_at, &validate/2)
    |> validate_number(:mass, greater_than: 0)
  end

  defp validate(:updated_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt -> [updated_at: "updated_at cannot be in the past"]
      _ -> []
    end
  end
end
