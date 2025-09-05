defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when not (is_integer(number) and number > 0), do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    aliquot = get_factors(number,1,0)
    cond do
      aliquot==number -> {:ok,:perfect}
      aliquot>number -> {:ok,:abundant}
      true -> {:ok,:deficient}
    end
  end

  def get_factors(number,div,factor_sum) do
    cond do
      number<=div -> factor_sum
      rem(number,div)==0 -> get_factors(number,div+1,div+factor_sum)
      true -> get_factors(number,div+1,factor_sum)
    end
  end

  
end
