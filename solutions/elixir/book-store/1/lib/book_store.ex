defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """

  @price_map %{1 => 800, 2 => 1520, 3 => 2160, 4 => 2560, 5 => 3000}

  @spec total(basket :: [book]) :: integer
  def total(basket) do
    f =
      basket
      |> Enum.frequencies()
      |> split_sets()

    Enum.map(f, &Map.get(@price_map, &1, 0)) |> Enum.sum()
  end

  def split_sets(books, acc \\ [])

  def split_sets(books, acc) when map_size(books) == 0 do
    if 3 not in acc or 5 not in acc,
      do: acc,
      else: split_sets(books, (acc -- [3, 5]) ++ [4, 4])
  end

  def split_sets(input, acc) do
    right =
      Enum.reject(input, fn {_, f} -> f == 0 end)
      |> Enum.map(fn {k, f} -> {k, f - 1} end)

    split_sets(Map.new(right), [length(right) | acc])
  end
end
