defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number < 2, do: []

  def factors_for(number) do
    split_to_factors(number)
  end

  def is_prime?(num, div \\ 2) do
    cond do
      num < 2 -> false
      div > :math.sqrt(num) -> true
      rem(num, div) != 0 -> is_prime?(num, div + 1)
      true -> false
    end
  end

  def next_prime(num \\ 2) do
    cond do
      is_prime?(num) -> num
      true -> next_prime(num + 1)
    end
  end

  def next_factor(num, div \\ 2) do
    pr = next_prime(div)

    cond do
      rem(num, pr) == 0 -> pr
      pr > :math.sqrt(num) -> num
      true -> next_factor(num, pr + 1)
    end
  end

  def prod([]), do: 1
  def prod([h | t]) when t == [], do: h

  def prod([h | t]) do
    h * prod(t)
  end

  def split_to_factors(num, start \\ []) do
    n = next_factor(num)

    cond do
      num == 1 -> start
      true -> split_to_factors(div(num, n), start ++ [n])
    end
  end
end
