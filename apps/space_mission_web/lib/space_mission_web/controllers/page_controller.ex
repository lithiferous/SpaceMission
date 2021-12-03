defmodule SpaceMissionWeb.PageController do
  use SpaceMissionWeb, :controller

  def index(conn, _params) do
    items = SpaceMission.list_items()
    render(conn, "index.html", items: items)
  end
end
