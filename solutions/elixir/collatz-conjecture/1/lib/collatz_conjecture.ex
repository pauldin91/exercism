defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()

  def calc(input) when input >= 1 and is_integer(input) do
    steps(input, 0)
  end

  def steps(input, step) when input == 1, do: step

  def steps(input, step) when input > 0 do
    cond do
      rem(input, 2) != 0 -> steps(input * 3 + 1, step + 1)
      true -> steps(div(input, 2), step + 1)
    end
  end
end
