defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(0), do: true

  def valid?(number) do
    s = Integer.to_string(number) |> String.length()

    number
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.map(fn c -> String.to_integer(c) |> Integer.pow(s) end)
    |> Enum.reduce(fn x, acc -> acc + x end) == number
  end
end
