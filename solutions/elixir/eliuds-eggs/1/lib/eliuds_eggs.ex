defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    number
    |> Integer.to_string(2)
    |> String.to_charlist()
    |> count()
  end

  defp count([]), do: 0
  defp count([?1 | t]), do: 1 + count(t)
  defp count([_ | t]), do: count(t)
end
