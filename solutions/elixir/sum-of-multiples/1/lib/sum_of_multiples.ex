defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer

  def to(limit, factors) do
    do_collect(limit, factors, [])
    |> Enum.reduce(MapSet.new(), fn x, acc -> MapSet.union(acc, MapSet.new(x)) end)
    |> Enum.sum()
  end

  def do_collect(_limit, [], acc), do: acc

  def do_collect(limit, [h | t], acc) do
    do_collect(limit, t, [do_to(limit, h, [h]) | acc])
  end

  defp do_to(limit, base, [h | _] = acc) do
    cond do
      base > limit -> []
      base == 0 -> [base]
      limit > h + base -> do_to(limit, base, [h + base | acc])
      true -> acc
    end
  end
end
