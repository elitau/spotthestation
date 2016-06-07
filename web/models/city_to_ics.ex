defmodule CityToIcs do
  import SweetXml
  @date_regex ~r/Date\: \w+ (?<month>\w+) (?<day>\d+), (?<year>\d+).*\<br/
  @time_regex ~r/Time\: (?<hours>\d+)\:(?<minutes>\d+) (?<pm_am>.*)\<br/

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
    |> extract_attributes
    |> create_event
  end

  def extract_description(item_as_xml) do
    item_as_xml |> xpath(~x"./description/text()"s)
  end

  defp extract_attributes(description) do
    date = Regex.named_captures(@date_regex, description)
    %{ "hours" => hours, "minutes" => minutes, "pm_am" => pm_am } = Regex.named_captures(@time_regex, description)
    %{
      start: {
        {String.to_integer(date["year"]), 12, 24},
        {to_hour(hours, pm_am), String.to_integer(minutes), 00}
      },
    }
  end

  defp to_hour(hours, pm_am) do
    if pm_am == "AM" do
      String.to_integer(hours)
    else
      String.to_integer(hours) + 12
    end
  end

  defp create_event(%{:start => start}) do
    %ICalendar.Event{
      summary: "summary",
      dtstart: start,
      dtend:   {{2015, 12, 24}, {8, 45, 00}},
      description: "Look up into the stars",
    }
  end
end
