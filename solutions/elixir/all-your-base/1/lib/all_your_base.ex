defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  def convert([], input_base, output_base) when input_base >= 2 and output_base >= 2,
    do: {:ok, [0]}

  def convert(_, input_base, _) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(_, _, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert(digits, input_base, output_base) when input_base >= 2 and output_base >= 2 do
    cond do
      Enum.any?(digits, fn c -> c < 0 end) ->
        {:error, "all digits must be >= 0 and < input base"}

      Enum.all?(digits, fn c -> c == 0 end) ->
        {:ok, [0]}

      Enum.any?(digits, fn c -> c >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        base_ten =
          Enum.reverse(digits)
          |> Enum.with_index(fn el, index -> AllYourBase.pow(input_base, index) * el end)
          |> Enum.reduce(fn x, acc -> acc + x end)

        {:ok, decomp([], base_ten, output_base)}
    end
  end

  def decomp(l, s, n) do
    di = div(s, n)
    rl = l ++ [rem(s, n)]

    cond do
      di >= n -> decomp(rl, di, n)
      di == 0 -> rl |> Enum.reverse()
      true -> (rl ++ [di]) |> Enum.reverse()
    end
  end

  def pow(_, n) when n == 0, do: 1

  def pow(s, n) when n > 0 do
    s * pow(s, n - 1)
  end
end
