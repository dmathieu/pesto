defmodule DurationTest do
  use ExUnit.Case
  doctest State

  test "to_string" do
    now = :calendar.universal_time
    |> :calendar.datetime_to_gregorian_seconds

    assert Duration.to_string((now + 60) |> :calendar.gregorian_seconds_to_datetime) == "1m"
    assert Duration.to_string((now + 90) |> :calendar.gregorian_seconds_to_datetime) == "1m, 30s"
    assert Duration.to_string((now + 3605) |> :calendar.gregorian_seconds_to_datetime) == "1h, 5s"
  end

  test "to_string for a finished event" do
    now = :calendar.universal_time
    |> :calendar.datetime_to_gregorian_seconds

    assert Duration.to_string((now - 5) |> :calendar.gregorian_seconds_to_datetime) == "N/A"
  end

end
