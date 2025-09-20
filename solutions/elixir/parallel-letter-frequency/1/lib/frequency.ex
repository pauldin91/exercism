defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}

  def frequency(texts, workers) do
    len = div(Enum.count(texts), workers)

    texts
    |> Enum.chunk_every(len)
    |> Enum.map(fn chunk ->
      Task.async(fn ->
        chunk
        |> Enum.join()
        |> String.downcase()
        |> String.replace(~r/[^\p{L}]/u, "")
        |> String.graphemes()
        |> Enum.frequencies()
      end)
    end)
    |> Task.await_many()
    |> Enum.reduce(fn x, acc -> Map.merge(x, acc, fn _k, v1, v2 -> v1 + v2 end) end)
  end
end
