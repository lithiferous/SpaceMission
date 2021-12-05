defmodule SpaceMissionWeb.PageController do
  use SpaceMissionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
