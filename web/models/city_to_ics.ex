defmodule CityToIcs do
  import SweetXml

  def for(city_name) do
    %ICalendar{ events: events(city_name) } |> ICalendar.to_ics
  end

  defp events(city_name) do
    city_name |> create_url |> fetch_xml |> xml_to_events
  end

  defp create_url(_city_name) do
    "https://spotthestation.nasa.gov/sightings/xml_files/Germany_None_Cologne.xml"
  end

  defp fetch_xml(url) do
    RssFeed.get_feed(url)
  end

  defp xml_to_events(xml) do
    xml
    |> xpath(~x"//item"l)
    |> Enum.map(fn (item) ->
      item_to_event(item)
    end)
  end

  defp item_to_event(item_as_xml) do
    item_as_xml
    |> extract_description
    |> EventAttributes.extract
    |> create_event
  end

  def extract_description(item_as_xml) do
    item_as_xml |> xpath(~x"./description/text()"s)
  end

  defp create_event(%{start_time: start_time, end_time: end_time, summary: summary}) do
    %ICalendar.Event{
      summary: summary,
      dtstart: start_time,
      dtend:   end_time,
      description: "Look up into the stars",
      alarms: [%ICalendar.Alarm{minutes_before: 5}]
    }
  end
end
