defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_rows([[1, 1], [1]], 2, num)
    |> Enum.reverse()
    |> Enum.take(num)
  end

  def do_rows(t, from, to) when from > to, do: t

  def do_rows([h | _] = l, num, to) do
    res =
      [
        1
        | for(
            i <- 1..div(num, 2),
            do: Enum.at(h, i - 1) + Enum.at(h, i)
          )
      ]
      |> Enum.reverse()

    append =
      cond do
        rem(num, 2) == 1 -> Enum.reverse(res)
        true -> tl(res) |> Enum.reverse()
      end

    do_rows([append ++ res | l], num + 1, to)
  end
end
