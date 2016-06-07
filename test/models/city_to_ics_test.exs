defmodule SpotTheStation.CityToIcsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes")
    :ok
  end

  @ics """
    BEGIN:VEVENT
    DESCRIPTION:Look up into the stars
    DTEND:20160607T222700Z
    DTSTART:20160607T223200Z
    SUMMARY:ISS is above you for 5 minutes appearing 20° above W and disappearing 10° above S.
    END:VEVENT
    """

  test "city_to_ics" do
    use_cassette "city_to_ics" do
      assert CityToIcs.for('Cologne') =~ @ics
    end
  end
end
