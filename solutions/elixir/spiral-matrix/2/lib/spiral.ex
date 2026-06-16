defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  def shift_left([h | t]) do
    t ++ [h]
  end

  def shift_right(m) do
    Enum.reverse(m) |> shift_left() |> Enum.reverse()
  end

  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(1), do: [[1]]

  def matrix(dimension) do
    1..(dimension * dimension)
    |> do_split([], wrap_mapping(dimension))
  end

  def do_split([], acc, []), do: acc
  def do_split(_range, acc, []), do: acc

  def do_split(range, acc, [{he, hf} | t]) do

    cond do
      hf >= 1 ->
        do_split(range |> Enum.drop(he), acc ++ [(range |> Enum.take(he))], [{he, hf - 1} | t])

      true ->
        do_split(range, acc, t)
    end
  end

  def wrap_mapping(num) do
    get_mapping(num)
    |> Enum.map(& &1)
    |> Enum.sort(:desc)
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
