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
      Enum.count(s1) != Enum.count(s2) ->
        {:error, "strands must be of equal length"}

      true ->
        {
          :ok,
          Enum.zip_reduce(s1, s2, 0, fn f, s, acc ->
            cond do
              f != s -> acc + 1
              true -> acc
            end
          end)
        }
    end
  end
end
