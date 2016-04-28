defmodule Pesto do

  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([]) do
    case State.read_event() do
      {:ok, finish_at} ->
        finish_at
        |> Duration.to_string
        |> IO.write
      {:error, err} -> IO.puts(err)
    end
  end

  def process([start: true]) do
    State.start_event()
    IO.puts "Event started"
  end

  def process([stop: true]) do
    State.finish_event()
    IO.puts "Event stopped"
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [start: :boolean, stop: :boolean])
    options
  end
end
