defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(s1, s2) do
    cond do
      Enum.count(s1) != Enum.count(s2) -> {:error, "strands must be of equal length"}
      true -> do_distance(s1, s2, 0)
    end
  end

  defp do_distance(l, [], num), do: {:ok, num + Enum.count(l)}
  defp do_distance([], l, num), do: {:ok, num + Enum.count(l)}

  defp do_distance([h1 | t1], [h2 | t2], num) do
    cond do
      h1 != h2 -> do_distance(t1, t2, num + 1)
      true -> do_distance(t1, t2, num)
    end
  end
end
