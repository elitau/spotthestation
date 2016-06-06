defmodule SpotTheStation.PageController do
  use SpotTheStation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def city_to_ics(conn, _params) do
    conn
    |> put_resp_content_type("text/calendar")
    |> text("VCALENDAR")
  end
end
