defmodule SpotTheStation.CityToIcsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
    :ok
  end

  @ics """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    DESCRIPTION:Look up into the stars
    DTEND:20151224T084500Z
    DTSTART:20151224T083000Z
    SUMMARY:ISS is above you for 6 minutes appearing 10° above W and disappearing 11° above E.
    END:VEVENT
    END:VCALENDAR
    """

  test "city_to_ics" do
    use_cassette "city_to_ics" do
      assert @ics == CityToIcs.for('cologne')
    end
  end
end
