defmodule SpaceMissionWeb.TripController do
  alias SpaceMission.Trips
  use SpaceMissionWeb, :controller

  def index(conn, _params) do
    trips = Trips.list()
    render(conn, "index.html", trips: trips)
  end

  def show(conn, %{"id" => id}) do
    trip = Trips.get(id)
    render(conn, "show.html", trip: trip)
  end
end
