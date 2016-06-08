defmodule EventAttributes do
  @date_regex ~r/Date\: \w+ (?<month>\w+) (?<day>\d+), (?<year>\d+).*\<br/
  @time_regex ~r/Time\: (?<hours>\d+)\:(?<minutes>\d+) (?<pm_am>.*)\<br/
  @duration_regex ~r/Duration\: (?<minutes>\d+).*\<br/

  def extract(description) do
    %{
      start_time: start_time(description),
      end_time: end_time(description)
    }
  end

  defp start_time(description) do
    %{ "month" => month, "day" => day, "year" => year } = date(description)
    %{ "hours" => hours, "minutes" => minutes, "pm_am" => pm_am } = time(description)
    {
      {String.to_integer(year), to_month_number(month), String.to_integer(day)},
      {to_hour(hours, pm_am), String.to_integer(minutes), 00}
    }
  end

  defp end_time(description) do
    {date, time} = start_time(description)
    {date, put_elem(time, 1, elem(time, 1) + duration(description))}
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
      "Dec" => 12,
    }[month_text]
  end

  defp duration(description) do
    try do
      [duration] = Regex.run(~r/Duration\:.*(?<minutes>\d+).*/, description, capture: :all_but_first)
      duration |> String.to_integer
    rescue
      e in MatchError -> e
      IO.puts description
      description
    end
  end
end
