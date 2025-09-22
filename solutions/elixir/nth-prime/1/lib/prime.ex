defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count>0 do
    do_nth(count-1,2)  
  end

  def do_nth(count,prime\\2) do 
    
    cond do
      count==0 && is_prime?(prime) -> prime
      true -> do_nth(count-1,next_prime(prime+1))
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

  def next_prime(num \\ 2) do
    cond do
      is_prime?(num) -> num
      true -> next_prime(num + 1)
    end
  end
end
