defmodule SpotTheStation.TimeEntry do
  defstruct [:year, :month, :day, :hour, :minute, :second]

  def new({{yy, mm, dd}, {h, m, s}}) do
    %__MODULE__{year: yy, month: mm, day: dd, hour: h, minute: m, second: s}
  end
end

defimpl ICalendar.Value, for: SpotTheStation.TimeEntry do
  def to_ics(%{year: yy, month: mm, day: dd, hour: h, minute: m, second: s}) do
    import String, only: [pad_leading: 3]
    year = yy |> to_string |> pad_leading(4, "0")
    month = mm |> to_string |> pad_leading(2, "0")
    day = dd |> to_string |> pad_leading(2, "0")
    hour = h |> to_string |> pad_leading(2, "0")
    min = m |> to_string |> pad_leading(2, "0")
    sec = s |> to_string |> pad_leading(2, "0")

    year <> month <> day <> "T" <> hour <> min <> sec
  end
end

defmodule CityToIcs do
  import SweetXml

  def for("Cologne") do
    cologne = %{"country" => "Germany", "region" => "None", "city" => "Cologne"}
    __MODULE__.for(cologne)
  end

  def for(location) do
    %ICalendar{events: events(location)} |> ICalendar.to_ics()
  end

  defp events(location) do
    location |> create_url |> fetch_xml |> xml_to_events
  end

  defp create_url(location) do
    "https://spotthestation.nasa.gov/sightings/xml_files/#{location["country"]}_#{location["region"]}_#{location["city"]}.xml"
  end

  defp fetch_xml(url) do
    RssFeed.get_feed(url)
  end

  defp xml_to_events(xml) do
    xml
    |> xpath(~x"//item"l)
    |> Enum.map(fn item ->
      item_to_event(item)
    end)
  end

  defp item_to_event(item_as_xml) do
    item_as_xml
    |> extract_description
    |> EventAttributes.extract()
    |> create_event
  end

  def extract_description(item_as_xml) do
    item_as_xml |> xpath(~x"./description/text()"s)
  end

  defp create_event(%{start_time: start_time, end_time: end_time, summary: summary}) do
    %ICalendar.Event{
      summary: summary,
      dtstart: SpotTheStation.TimeEntry.new(start_time),
      dtend: SpotTheStation.TimeEntry.new(end_time),
      description: "Look up into the stars",
      alarms: [%ICalendar.Alarm{minutes_before: 5}]
    }
  end
end
