defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: %__MODULE__{
            state: SplitSecondStopwatch.state(),
            current: Time.t(),
            laps: [Time.t()]
          }
    defstruct [:state, :current, :laps]
  end

  ## Helpers

  defp zero(), do: ~T[00:00:00]

  defp add_times(%Time{} = t1, %Time{} = t2) do
    Time.add(t1, Time.diff(t2, zero()))
  end

  defp sum_times(times) do
    times
    |> Enum.reduce(zero(), fn t, acc -> add_times(acc, t) end)
  end

  ## API

  @spec new() :: Stopwatch.t()
  def new() do
    %Stopwatch{state: :ready, current: zero(), laps: []}
  end

  @spec state(Stopwatch.t()) :: state()
  def state(sw), do: sw.state

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(sw), do: sw.current

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(sw), do: sw.laps

  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(%Stopwatch{state: :running} = sw, time) do
    %{sw | current: add_times(sw.current, time)}
  end

  def advance_time(sw, _), do: sw

  @spec total(Stopwatch.t()) :: Time.t()
  def total(%Stopwatch{state: :ready}), do: zero()

  def total(%Stopwatch{laps: laps, current: current}) do
    sum_times(laps ++ [current])
  end

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(%Stopwatch{state: s}) when s != :ready and s != :stopped,
    do: {:error, "cannot start an already running stopwatch"}

  def start(%Stopwatch{state: :ready}) do
    %Stopwatch{state: :running, current: zero(), laps: []}
  end

  def start(%Stopwatch{state: :stopped} = sw) do
    %Stopwatch{
      state: :running,
      current: sw.current,
      laps: sw.laps
    }
  end

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(%Stopwatch{state: s}) when s != :running,
    do: {:error, "cannot stop a stopwatch that is not running"}

  def stop(%Stopwatch{state: :running} = sw) do
    %{sw | state: :stopped}
  end

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}

  def lap(%Stopwatch{state: s}) when s != :running,
    do: {:error, "cannot lap a stopwatch that is not running"}

  def lap(%Stopwatch{state: :running, current: current, laps: laps} = sw) do
    %{sw | laps: laps ++ [current], current: zero()}
  end

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}

  def reset(%Stopwatch{state: s}) when s != :stopped,
    do: {:error, "cannot reset a stopwatch that is not stopped"}

  def reset(%Stopwatch{state: :stopped}) do
    %Stopwatch{state: :ready, current: zero(), laps: []}
  end
end
