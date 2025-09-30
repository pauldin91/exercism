defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map

  def generate(max_factor, min_factor \\ 1) when max_factor >= min_factor do
    all =
      for n <- min_factor..max_factor,
          k <- n..max_factor,
          palindrome?(Integer.to_string(n * k)) do
        n * k
      end

    cond do
      Enum.count(all) == 0 ->
        %{}

      true ->
        minimum = Enum.min(all)
        maximum = Enum.max(all)

        %{
          minimum => factors(minimum, max_factor, min_factor),
          maximum => factors(maximum, max_factor, min_factor)
        }
    end
  end

  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise(ArgumentError)

  def factors(num, max_factor, min_factor) do
    1..num
    |> Enum.filter(fn s -> rem(num, s) == 0 end)
    |> Enum.map(fn s -> [s, div(num, s)] |> Enum.sort() end)
    |> Enum.uniq()
    |> Enum.filter(fn [a, b] ->
      a <= max_factor and b <= max_factor and a >= min_factor and b >= min_factor
    end)
  end

  def palindrome?(s) do
    rev = String.graphemes(s) |> Enum.reverse()

    String.graphemes(s)
    |> Enum.zip(rev)
    |> Enum.with_index()
    |> Enum.take_while(fn {{_k1, _k2}, idx} ->
      idx <= Integer.floor_div(String.length(s), 2)
    end)
    |> Enum.all?(fn {{k1, k2}, _idx} -> k1 == k2 end)
  end
end
