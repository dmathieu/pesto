defmodule State do
  @event_duration 60 * 25 # 25 minutes

  def start_event(path \\ state_path, duration \\ @event_duration) do
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

  def finish_event(path \\ state_path) do
    case File.rm(path) do
      :ok -> :ok
      {:error, err} ->
        case err do
          :enoent -> :ok
          true -> {:error, err}
        end
    end
  end

  def read_event(path \\ state_path) do
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
