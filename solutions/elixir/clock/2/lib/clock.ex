defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    do_minutes(hour, minute)
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    do_minutes(hour, minute + add_minute)
  end

  defp do_minutes(hour, minute) do
    min = rem(minute, 60)
    hr = hour + div(minute, 60)

    r =
      cond do
        rem(minute, 60) != 0 -> 1
        true -> 0
      end

    {minutes, h} =
      cond do
        minute >= 0 ->
          {min, hr}

        true ->
          {rem(60 + min, 60), hr - r}
      end

    hours =
      cond do
        h >= 0 ->
          rem(h, 24)

        true ->
          rem(24 - rem(-h, 24), 24)
      end

    %Clock{hour: hours, minute: minutes}
  end
end

defimpl String.Chars, for: Clock do
  @spec to_string(Clock) :: String.t()
  def to_string(clock) do
    m =
      cond do
        clock.minute < 10 -> "0#{clock.minute}"
        true -> "#{clock.minute}"
      end

    h =
      cond do
        clock.hour < 10 -> "0#{clock.hour}"
        true -> "#{clock.hour}"
      end

    "#{h}:#{m}"
  end
end
