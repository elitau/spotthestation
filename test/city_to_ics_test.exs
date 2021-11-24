defmodule SpotTheStation.CityToIcsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
    :ok
  end

  @ics "BEGIN:VCALENDAR
CALSCALE:GREGORIAN
VERSION:2.0
BEGIN:VEVENT
BEGIN:VALARM
TRIGGER:-PT5M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
DESCRIPTION:Look up into the stars
DTEND:20160603T222400
DTSTART:20160603T221800
SUMMARY:ISS is above you for 6 minutes appearing 10° above W and disappearing 11° above E.
END:VEVENT
BEGIN:VEVENT
BEGIN:VALARM
TRIGGER:-PT5M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
DESCRIPTION:Look up into the stars
DTEND:20160604T000100
DTSTART:20160603T235500
SUMMARY:ISS is above you for 6 minutes appearing 10° above W and disappearing 13° above ESE.
END:VEVENT
END:VCALENDAR
"

  test "city_to_ics" do
    use_cassette "city_to_ics" do
      assert CityToIcs.for("Cologne") =~ @ics
    end
  end
end
