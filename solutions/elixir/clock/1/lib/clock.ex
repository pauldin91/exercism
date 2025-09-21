defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    {m, hours} = do_minutes(hour, minute)

    h =
      cond do
        hours >= 0 ->
          rem(hours, 24)

        true ->
          rem(24 - rem(-hours, 24), 24)
      end

    %Clock{hour: h, minute: m}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    total_minute = minute + add_minute

    {m, hours} = do_minutes(hour, total_minute)

    h =
      cond do
        hours >= 0 ->
          rem(hours, 24)

        true ->
          rem(24 - rem(-hours, 24), 24)
      end

    %Clock{hour: h, minute: m}
  end

  defp do_minutes(hour, minute) do
    cond do
      minute >= 0 ->
        {rem(minute, 60), div(minute, 60) + hour}

      rem(minute, 60) == 0 ->
        {rem(60 - rem(-minute, 60), 60), hour + div(minute, 60)}

      true ->
        {rem(60 - rem(-minute, 60), 60), hour + div(minute, 60) - 1}
    end
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
