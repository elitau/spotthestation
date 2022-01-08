defmodule EventAttributes do
  import SweetXml
  use Timex
  @date_regex ~r/Date\: \w+ (?<month>\w+) (?<day>\d+), (?<year>\d+).*\<br/
  @time_regex ~r/Time\: (?<hours>\d+)\:(?<minutes>\d+) (?<pm_am>.*)\<br/
  @duration_regex ~r/Duration\:.*(?<minutes>\d+).*/
  @approach_regex ~r/Approach\: (.*)\<br/
  @departure_regex ~r/Departure\: (.*)\<br/
  @title_regex ~r/^\d\d\d\d-\d\d-\d\d (.+) Sighting$/

  def extract(item) do
    description = item |> xpath(~x"./description/text()"s)
    title = item |> xpath(~x"./title/text()"s)

    %{
      start_time: start_time(description),
      end_time: end_time(description),
      summary: summary(description, title)
    }
  end

  defp start_time(description) do
    %{"month" => month, "day" => day, "year" => year} = date(description)
    %{"hours" => hours, "minutes" => minutes, "pm_am" => pm_am} = time(description)

    {
      {String.to_integer(year), to_month_number(month), String.to_integer(day)},
      {to_hour(hours, pm_am), String.to_integer(minutes), 00}
    }
  end

  defp end_time(description) do
    date_time = Timex.to_datetime(start_time(description), "Europe/Berlin")
    with_duration = Timex.shift(date_time, minutes: duration(description))
    # Timex.format!(with_duration, "{ISO:Extended}")
    Timex.to_erl(with_duration)
  end

  defp date(description) do
    Regex.named_captures(@date_regex, description)
  end

  defp time(description) do
    Regex.named_captures(@time_regex, description)
  end

  defp to_hour(hours, pm_am) do
    if pm_am == "AM" do
      String.to_integer(hours)
    else
      String.to_integer(hours) + 12
    end
  end

  defp to_month_number(month_text) do
    %{
      "Jan" => 1,
      "Feb" => 2,
      "Mar" => 3,
      "Apr" => 4,
      "May" => 5,
      "Jun" => 6,
      "Jul" => 7,
      "Aug" => 8,
      "Sep" => 9,
      "Oct" => 10,
      "Nov" => 11,
      "Dec" => 12
    }[month_text]
  end

  defp duration(description) do
    parse_attribute(@duration_regex, description) |> String.to_integer()
  end

  defp summary(description, title) do
    title = parse_attribute(@title_regex, title)

    "#{title} is above you for #{duration(description)} minutes appearing #{approach(description)} and disappearing #{departure(description)}."
  end

  defp approach(description) do
    parse_attribute(@approach_regex, description) |> String.trim()
  end

  defp departure(description) do
    parse_attribute(@departure_regex, description) |> String.trim()
  end

  def title(xml_content) do
    parse_attribute(@title_regex, xml_content) |> String.trim()
  end

  defp parse_attribute(regexp, description) do
    [match] = Regex.run(regexp, description, capture: :all_but_first)
    match
  end
end
