defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """

  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(1), do: [[1]]

  def matrix(dimension) do
    1..(dimension * dimension)

  end

  def shift_left([h | t]) do
    t ++ [h]
  end

  def shift_right(m) do
    Enum.reverse(m) |> shift_left() |> Enum.reverse()
  end






  def get_mapping(num) do
    cond do
      num < 1 ->
        %{}

      num == 1 ->
        %{1 => 1}

      num == 2 ->
        %{2 => 1, 1 => 2}

      num == 3 ->
        %{3 => 1, 2 => 3}

      true ->
        Map.merge(%{num => 1, (num - 1) => 1}, get_mapping(num - 1), fn _k, v1, v2 -> v1 + v2 end)
    end
  end
end
