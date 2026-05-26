defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    Enum.sum(triplet)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    Enum.product(triplet)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a > 0 && b > 0 && c > 0 &&
      (c * c == a * a + b * b or b * b == a * a + c * c or a * a == b * b + c * c)
  end

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(num) do
    1..num
    |> Enum.map(&do_cartesian/1)
    |> Enum.reduce([], fn x, acc -> acc ++ x end)
    |> Enum.filter(fn x -> pythagorean?([num - Enum.at(x, 0) - Enum.at(x, 1) | x]) end)
    |> Enum.map(fn x -> Enum.sort([num - Enum.at(x, 0) - Enum.at(x, 1) | x]) end)
    |> Enum.sort()
    |> Enum.dedup()
  end

  def do_cartesian(num) do
    1..num
    |> Enum.map(&[&1, num])
  end
end
