defmodule SpotTheStation2.PageControllerTest do
  use Spotthestation2Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  test "GET /cologne.ics", %{conn: conn} do
    conn = get(conn, "/cologne.ics")
    assert response(conn, 200) =~ "VCALENDAR"
    # TODO: Test the mime type
    # assert response_content_type(conn, :"text/calendar")
  end

  test "GET /for_city", %{conn: conn} do
    conn = get(conn, "/for_city", country: "Germany", region: "None", city: "Cologne")
    assert response(conn, 200) =~ "VCALENDAR"
    # TODO: Test the mime type
    # assert response_content_type(conn, :"text/calendar")
  end
end
