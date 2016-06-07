defmodule CityToIcs do
  def for(city_name) do
    events = [
      %ICalendar.Event{
        summary: "ISS is above you for 6 minutes appearing 10° above W and disappearing 11° above E.",
        dtstart: {{2015, 12, 24}, {8, 30, 00}},
        dtend:   {{2015, 12, 24}, {8, 45, 00}},
        description: "Look up into the stars",
      }
    ]
    ics = %ICalendar{ events: events } |> ICalendar.to_ics
  end
end
