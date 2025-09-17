defmodule LucasNumbers do

  def generate(count) when is_integer(count) and count >= 1 do
    do_generate(count, [2, 1])
  end

  def generate(_count), do: raise ArgumentError, "count must be specified as an integer >= 1"

  defp do_generate(count, base) when count <= 2 do
    Enum.take(base, count)
  end

  defp do_generate(count, base) do
    do_generate(count, base, 2)
  end

  defp do_generate(count, seq, n) when n >= count, do: seq

  defp do_generate(count, seq, n) do
    [a, b | _] = Enum.reverse(seq)
    do_generate(count, seq ++ [a + b], n + 1)
  end
end
