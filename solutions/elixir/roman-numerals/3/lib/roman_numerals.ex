defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @mapping %{
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }
  @ranks @mapping |> Enum.map(fn {k, _} -> k end) |> Enum.sort(:desc)

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_map(number, @ranks, "")
  end

  def do_map(_, [], l), do: l

  def do_map(number, [h | t], l) do
    d = div(number, h)
    r = rem(number, h)

    cond do
      r >= 0 && r < number ->
        do_map(r, t, l <> String.duplicate(Map.get(@mapping, h, ""), d))

      true ->
        do_map(number, t, l)
    end
  end
end
