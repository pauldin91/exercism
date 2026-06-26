defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []

  def tick(matrix) do
    size = length(matrix)

    make_map(matrix, size)
    |> apply_rules(size)
    |> Enum.map(fn {_i, v} -> v end)
    |> Enum.chunk_every(size)
  end

  def make_map(matrix, size),
    do:
      Enum.zip(
        0..(size * size - 1),
        Enum.reduce(matrix, [], fn x, acc -> acc ++ x end)
      )
      |> Map.new()

  def calculate_cell(the_map, i, size) do
    sum_row(indices(i, size), the_map) +
      Map.get(the_map, i - 1, 0) + Map.get(the_map, i + 1, 0) +
      sum_row(indices(i, size), the_map)
  end

  def indices(i, size) do
    (i - 1 + size)..(i + 1 + size)
  end

  def apply_rules(the_map, size) do
    Enum.map(the_map, fn
      {i, v} ->
        total = calculate_cell(the_map, i, size)

        cond do
          total == 3 and v == 0 ->
            {i, 1}

          2 <= total and total <= 3 and v == 1 ->
            {i, v}

          true ->
            {i, 0}
        end
    end)
  end

  def sum_row(row, the_map), do: Enum.map(row, fn x -> Map.get(the_map, x, 0) end) |> Enum.sum()
end
