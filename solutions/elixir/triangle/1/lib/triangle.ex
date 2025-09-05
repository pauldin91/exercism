defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
      cond do
        a <=0||b<=0||c<=0 -> {:error, "all side lengths must be positive"}
        (a + b < c || a+c<b ||  b + c < a) -> {:error,"side lengths violate triangle inequality"}
        a != b && b != c && c != a -> {:ok,:scalene}
        ((a == b && b != c) || (a != b && b==c) || (a==c && b != c)) -> {:ok,:isosceles}
        a == b && b == c -> {:ok,:equilateral}
        true -> {:error,"side lengths violate triangle inequality"}
      end
  end
end
