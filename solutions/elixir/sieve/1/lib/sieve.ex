defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit<2, do: []
  def primes_to(limit) when limit==2, do: [2]
  def primes_to(limit) when limit>=3 do
      do_primes_to(limit,3,[2])
  end

  def do_primes_to(limit,num, [h|_]=acc) do
      cond do
        num > limit -> acc |> Enum.reverse
        is_prime?(num) -> do_primes_to(limit,num+1,[num|acc])
        true -> do_primes_to(limit,num+1,acc)
      end
  end

  def is_prime?(num, div \\ 2) do
    cond do
      num < 2 -> false
      div > :math.sqrt(num) -> true
      rem(num, div) != 0 -> is_prime?(num, div + 1)
      true -> false
    end
  end
end
