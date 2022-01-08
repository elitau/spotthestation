defmodule SpotTheStation.EventAttributesTest do
  use ExUnit.Case

  @iss_sighting_item "<item>
    <title>2021-12-09 ISS Sighting</title>
    <pubDate>10 Dec 2021 04:44:29 GMT</pubDate>
    <description>
    Date: Friday Dec 21, 2016 &lt;br/&gt;
    Time: 10:59 PM &lt;br/&gt;
    Duration: less than 3 minute &lt;br/&gt;
    Maximum Elevation: 15&#176; &lt;br/&gt;
    Approach: 10&#176; above W &lt;br/&gt;
    Departure: 10&#176; above S &lt;br/&gt;
    </description>
    <guid>https://spotthestation.nasa.gov/sightings/view.cfm?country=United_States&amp;region=Washington&amp;city=Seattle&amp;ss=5A918FC6-ED9D-2E3C-8032F38DEE170717</guid>
  </item>"

  test "extract start_time" do
    assert {{2016, 12, 21}, {22, 59, 0}} ==
             EventAttributes.extract(@iss_sighting_item)[:start_time]
  end

  test "extract end" do
    assert {{2016, 12, 21}, {23, 2, 0}} == EventAttributes.extract(@iss_sighting_item)[:end_time]
  end

  test "summary" do
    assert "ISS is above you for 3 minutes appearing 10° above W and disappearing 10° above S." ==
             EventAttributes.extract(@iss_sighting_item)[:summary]
  end

  test "summary for Cygnus sighting" do
    cygnus_sighting_item = "<item>
    <title>2021-12-09 Cygnus Sighting</title>
    <pubDate>10 Dec 2021 04:44:29 GMT</pubDate>
    <description>
    Date: Thursday Dec 9, 2021 &lt;br/&gt;
    Time: 4:56 PM &lt;br/&gt;
    Duration: 7 minutes &lt;br/&gt;
    Maximum Elevation: 34&#176; &lt;br/&gt;
    Approach: 10&#176; above WNW &lt;br/&gt;
    Departure: 10&#176; above SSE &lt;br/&gt;
    </description>
    <guid>https://spotthestation.nasa.gov/sightings/view.cfm?country=United_States&amp;region=Washington&amp;city=Seattle&amp;ss=5A918FC5-E07B-635D-BA514485A163AC2A</guid>
  </item>"

    assert "Cygnus is above you for 7 minutes appearing 10° above WNW and disappearing 10° above SSE." ==
             EventAttributes.extract(cygnus_sighting_item)[:summary]
  end
end
