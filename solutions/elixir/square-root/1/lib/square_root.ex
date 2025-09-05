defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    calc(radicand, 1)
  end

  defp calc(rd, from) do
    s = from * from

    cond do
      s < rd -> calc(rd, from + 1)
      s == rd -> from
      true -> 0
    end
  end
end
