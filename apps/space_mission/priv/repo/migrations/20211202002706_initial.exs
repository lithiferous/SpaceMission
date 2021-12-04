defmodule SpaceMission.Repo.Migrations.Initial do
  use Ecto.Migration

  def change do
    create table(:planets) do
      add(:name, :string, null: false)
      add(:gravity, :float, null: false)
    end

    create(index("planets", [:name], unique: true))

    create table(:trips) do
      add(:mass, :integer, null: false)
      timestamps()
    end

    # create(index("trips", [:mass]))

    create table(:stages) do
      add(:type, :string, null: false)
      add(:planet_id, references("planets"), null: false)
      add(:trip_id, references("trips"), null: false)
      timestamps()
    end

    # create(index("stages", [:inserted_at, :type, :planet_id], unique: true))
  end
end
