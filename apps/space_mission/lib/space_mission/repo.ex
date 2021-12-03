defmodule SpaceMission.Repo do
  use Ecto.Repo,
    otp_app: :space_mission,
    adapter: Ecto.Adapters.Postgres
end
