defmodule StateTest do
  use ExUnit.Case
  doctest State

  test "start_event" do
    tmpPath = Enum.join(["/tmp/", "pesto_temp_", :erlang.phash2(make_ref())])
    now = :calendar.universal_time
    |> :calendar.datetime_to_gregorian_seconds

    assert State.start_event(tmpPath, 60) == :ok
    assert File.read(tmpPath) == {:ok, to_string(now + 60)}
  end

  test "finish_event" do
    tmpPath = Enum.join(["/tmp/", "pesto_temp_", :erlang.phash2(make_ref())])

    State.start_event(tmpPath, 60)
    assert State.finish_event(tmpPath) == :ok
  end

  test "finish unstarted event" do
    tmpPath = Enum.join(["/tmp/", "pesto_temp_", :erlang.phash2(make_ref())])
    assert State.finish_event(tmpPath) == :ok
  end

  test "read_event" do
    tmpPath = Enum.join(["/tmp/", "pesto_temp_", :erlang.phash2(make_ref())])
    now = :calendar.universal_time
    |> :calendar.datetime_to_gregorian_seconds
    expected = 60 + now
    |> :calendar.gregorian_seconds_to_datetime

    assert State.start_event(tmpPath, 60) == :ok
    assert State.read_event(tmpPath) == {:ok, expected}
  end

  test "read unstarted event" do
    tmpPath = Enum.join(["/tmp/", "pesto_temp_", :erlang.phash2(make_ref())])
    assert State.read_event(tmpPath) == {:error, :unstarted}
  end

  test "state_path" do
    assert State.state_path == Path.join(System.user_home, ".pestostate")
  end
end
