defmodule SpotTheStation.PageController do
  use SpotTheStation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def cologne(conn, _params) do
    conn
    |> put_resp_content_type("text/calendar")
    |> text(CityToIcs.for("Cologne"))
  end

  def for_city(conn, params) do
    conn
    |> put_resp_content_type("text/calendar")
    |> text(CityToIcs.for(params))
  end

  def city_to_ics(conn, _params) do
    conn
    |> put_resp_content_type("text/calendar")
    |> text(CityToIcs.for('Cologne'))
  end
end
