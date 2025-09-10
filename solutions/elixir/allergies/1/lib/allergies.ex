defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    Integer.to_string(flags, 2)
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {index, c} -> mapping(c, index) end)
    |> Enum.filter(fn s -> s != "" end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    res =
      Integer.to_string(flags, 2)
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {index, c} -> mapping(c, index) end)
      |> Enum.find(fn c -> c == item end)

    cond do
      res != nil -> true
      true -> false
    end
  end

  def mapping(pos, number) do
    cond do
      number == "1" && pos == 0 -> "eggs"
      number == "1" && pos == 1 -> "peanuts"
      number == "1" && pos == 2 -> "shellfish"
      number == "1" && pos == 3 -> "strawberries"
      number == "1" && pos == 4 -> "tomatoes"
      number == "1" && pos == 5 -> "chocolate"
      number == "1" && pos == 6 -> "pollen"
      number == "1" && pos == 7 -> "cats"
      true -> ""
    end
  end
end
