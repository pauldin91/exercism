defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.map(fn {p, l} -> for n <- l, do: %{String.downcase(n) => p} end)
    |> Enum.reduce(%{}, fn s, acc -> flatten(acc, s) end)
  end

  defp flatten(map, []), do: map

  defp flatten(map, [h | t]) do
    Map.merge(h, flatten(map, t))
  end
end
