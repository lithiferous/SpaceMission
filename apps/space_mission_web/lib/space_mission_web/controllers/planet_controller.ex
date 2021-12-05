defmodule SpaceMissionWeb.PlanetController do
  use SpaceMissionWeb, :controller
  alias SpaceMission.Planets

  def index(conn, _params) do
    planet = Planets.list()
    render(conn, "index.html", planets: planet)
  end

  def show(conn, %{"id" => id}) do
    planet = Planets.get(id)
    render(conn, "show.html", planet: planet)
  end
end
