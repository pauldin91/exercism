defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """

  @prev %{10 => 1, 100 => 10, 1000 => 100, 99 => 9, 999 => 99, 9999 => 999}
  @spec generate(non_neg_integer, non_neg_integer) :: map

  def generate(max_factor, min_factor \\ 1) do
    cond do
      max_factor < min_factor ->
        raise ArgumentError

      true ->
        minimum =
          do_find_min(min_factor * min_factor, min_factor, max_factor)

        maximum =
          do_find_max(max_factor * max_factor, min_factor, max_factor)

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

  def factors(num, min_factor, max_factor) do
    1..floor(:math.sqrt(num))
    |> Enum.filter(fn s ->
      r = rem(num, s)
      d = div(num, s)
      r == 0 and s <= max_factor and d <= max_factor and s >= min_factor and d >= min_factor
    end)
    |> Enum.flat_map(fn s -> [[s, div(num, s)]] end)
    |> Enum.uniq()
  end

  def palindrome?(s) do
    str = Integer.to_string(s)
    str == String.reverse(str)
  end
end
