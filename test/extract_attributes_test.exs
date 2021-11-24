defmodule SpotTheStation.EventAttributesTest do
  use ExUnit.Case

  @description "\n\t\t\t\tDate: Friday Dec 21, 2016 <br/>\n\t\t\t\tTime: 10:59 PM <br/>\n\t\t\t\tDuration: less than 3 minute <br/>\n\t\t\t\tMaximum Elevation: 81° <br/>\n\t\t\t\tApproach: 10° above W <br/>\n\t\t\t\tDeparture: 11° above E <br/>\n\t\t\t\t"

  test "extract start_time" do
    assert {{2016, 12, 21}, {22, 59, 0}} ==
             EventAttributes.extract(@description)[:start_time]
  end

  test "extract end" do
    assert {{2016, 12, 21}, {23, 2, 0}} == EventAttributes.extract(@description)[:end_time]
  end

  test "summary" do
    assert "ISS is above you for 3 minutes appearing 10° above W and disappearing 11° above E." ==
             EventAttributes.extract(@description)[:summary]
  end
end
