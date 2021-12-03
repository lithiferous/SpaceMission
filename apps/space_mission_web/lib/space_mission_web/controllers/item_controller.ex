defmodule SpaceMissionWeb.ItemController do
  use SpaceMissionWeb, :controller

  def index(conn, _params) do
    items = SpaceMission.list_items()
    render(conn, "index.html", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = SpaceMission.get_item(id)
    render(conn, "show.html", item: item)
  end
end
