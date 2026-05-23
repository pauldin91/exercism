defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %Matrix{
      matrix:
        String.split(input, "\n")
        |> Enum.map(fn s ->
          String.split(s, " ") |> Enum.map(fn s -> String.to_integer(s) end)
        end)
        |> Enum.map(fn arr -> arr |> Enum.with_index() end)
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.matrix
    |> Enum.map(fn row -> row |> Enum.map(fn {f, _} -> f end) |> Enum.join(" ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    Enum.map(matrix.matrix, &(&1 |> Enum.map(fn {n, _} -> n end)))
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(matrix.matrix, index - 1) |> Enum.map(fn {s, _} -> s end)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    matrix.matrix
    |> Enum.map(fn s -> Enum.group_by(s, fn {_, i} -> i end) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc, fn _k, v1, v2 -> v2 ++ v1 end) end)
    |> Enum.map(fn {_, v} -> v |> Enum.map(fn {f, _} -> f end) end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix.matrix
    |> Enum.map(fn y ->
      hd(
        Enum.reduce(y, [], fn x, acc ->
          cond do
            elem(x, 1) == index - 1 -> acc ++ [x]
            true -> acc
          end
        end)
      )
    end)
    |> Enum.map(&elem(&1, 0))
  end
end
