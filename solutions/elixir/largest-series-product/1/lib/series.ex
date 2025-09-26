defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(s, size) do
    cond do
      size < 1 or size > String.length(s) ->
        raise ArgumentError

      true ->
        do_slices(String.graphemes(s), size, 0, [])
        |> Enum.map(fn s -> Enum.reduce(s, 1, fn c, acc -> String.to_integer(c) * acc end) end)
        |> Enum.max()
    end
  end

  def do_slices(s, size, offset, acc) do
    cond do
      offset + size > Enum.count(s) -> acc
      true -> do_slices(s, size, offset + 1, acc ++ [Enum.slice(s, offset, size)])
    end
  end
end
