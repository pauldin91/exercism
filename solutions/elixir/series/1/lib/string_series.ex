defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    cond do
      size < 1 or size > String.length(s) -> []
      true -> do_slices(String.graphemes(s), size, 0, [])
    end
  end

  def do_slices(s, size, offset, acc) do
    cond do
      offset + size > Enum.count(s) -> acc
      true -> do_slices(s, size, offset + 1, acc ++ [Enum.slice(s, offset, size) |> Enum.join()])
    end
  end
end
