defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """

  @prev %{10 => 1, 100 => 10, 1000 => 100, 99 => 9, 999 => 99, 9999 => 999}
  @spec generate(non_neg_integer, non_neg_integer) :: map

  def generate(max_factor, min_factor \\ 1) when max_factor >= min_factor do
    cond do
      max_factor < 10 ->
        %{1 => [[1, 1]], 9 => [[1, 9], [3, 3]]}

      true ->
        minimum =
          do_find_min(min_factor * min_factor, min_factor, max_factor)

        maximum =
          do_find_max(max_factor * max_factor, min_factor, max_factor)

        # %{min: minimum, max: maximum}

        cond do
          minimum != nil and maximum != nil ->
            %{
              minimum => factors(minimum, min_factor, max_factor),
              maximum => factors(maximum, min_factor, max_factor)
            }

          true ->
            %{}
        end
    end
  end

  def do_find_min(f, _min_factor, max_factor) when f > max_factor * max_factor, do: nil

  def do_find_min(f, min_factor, max_factor) do
    cond do
      palindrome?(f) and factors(f, min_factor, max_factor) |> Enum.count() != 0 -> f
      true -> do_find_min(f + 1, min_factor, max_factor)
    end
  end

  def do_find_max(f, min_factor, _max_factor) when f < min_factor * min_factor, do: nil

  def do_find_max(f, min_factor, max_factor) do
    cond do
      palindrome?(f) and factors(f, min_factor, max_factor) |> Enum.count() != 0 -> f
      true -> do_find_max(f - 1, min_factor, max_factor)
    end
  end

  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise(ArgumentError)

  def naive_generate(max_factor, min_factor \\ 1) when max_factor >= min_factor do
    all =
      for n <- min_factor..max_factor,
          k <- n..max_factor,
          palindrome?(n * k) do
        n * k
      end

    # cond do
    #   Enum.count(all) == 0 ->
    #     %{}

    #   true ->
    #     minimum = Enum.min(all)
    #     maximum = Enum.max(all)

    #     %{
    #       minimum => factors(minimum, min_factor,max_factor),
    #       maximum => factors(maximum, min_factor,max_factor)
    #     }
    # end
  end

  def naive_generate(max_factor, min_factor) when max_factor < min_factor,
    do: raise(ArgumentError)

  def factors(num, min_factor, max_factor) do
    1..floor(:math.sqrt(num))
    |> Enum.filter(fn s -> rem(num, s) == 0 end)
    |> Enum.flat_map(fn s -> [[s, div(num, s)]] end)
    |> Enum.map(&Enum.sort/1)
    |> Enum.uniq()
    |> Enum.filter(fn [a, b] ->
      a <= max_factor and b <= max_factor and a >= min_factor and b >= min_factor
    end)
  end

  def palindrome?(s) do
    str = Integer.to_string(s)
    str == String.reverse(str)
  end
end
