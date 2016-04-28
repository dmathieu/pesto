defmodule State do
  @event_duration 60 * 24 # 24 minutes

  def start_event(), do: start_event(state_path, @event_duration)
  def start_event(duration), do: start_event(state_path, duration)
  def start_event(path, duration) do
    case File.open(path, [:write]) do
      {:ok, file} ->
        time = duration |> finish_at |> to_string
        file |> IO.binwrite(time)
        file |> File.close
        :ok
      {:error, err} ->
        {:error, err}
    end
  end

  def finish_event(), do: finish_event(state_path)
  def finish_event(path) do
    case File.rm(path) do
      :ok -> :ok
      {:error, err} ->
        case err do
          :enoent -> :ok
          true -> {:error, err}
        end
    end
  end

  def read_event, do: read_event(state_path)
  def read_event(path) do
    case File.read(path) do
      {:ok, content} ->
        {:ok, content
         |> String.to_integer
        |> :calendar.gregorian_seconds_to_datetime
        }
      {:error, err} ->
        case err do
          :enoent -> {:error, :unstarted}
          true -> {:error, err}
        end
    end
  end

  def state_path do
    System.user_home!
    |> Path.join(".pestostate")
  end

  defp finish_at(duration) do
    now = :calendar.universal_time
          |> :calendar.datetime_to_gregorian_seconds
    now + duration
  end
end
