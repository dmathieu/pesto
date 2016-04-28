defmodule Duration do

  def to_string(time) do
    time
    |> duration
    |> make_string
  end

  def make_string({-1, {_, _, _}}), do: "finished"
  def make_string({0, {0, m, 0}}), do: "#{m}m"
  def make_string({0, {0, 0, s}}), do: "#{s}s"
  def make_string({0, {h, 0, 0}}), do: "#{h}h"
  def make_string({0, {h, m, 0}}), do: "#{h}h, #{m}m"
  def make_string({0, {h, 0, s}}), do: "#{h}h, #{s}s"
  def make_string({0, {0, m, s}}), do: "#{m}m, #{s}s"
  def make_string({0, {h, m, s}}), do: "#{h}h, #{m}m, #{s}s"

  defp duration(time) do
    :calendar.universal_time
    |> :calendar.time_difference(time)
  end
end
