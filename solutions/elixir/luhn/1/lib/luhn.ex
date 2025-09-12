defmodule Luhn do
  @doc """
  Checks if the given number is valid via the Luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    digits =
      number
      |> String.replace(" ", "")
      |> String.graphemes()

    if length(digits) <= 1 or Enum.any?(digits, &(!String.match?(&1, ~r/^\d$/))) do
      false
    else
      digits
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {d, idx} ->
        n = String.to_integer(d)

        cond do
          rem(idx, 2) == 1 ->
            doubled = n * 2

            cond do
              doubled > 9 -> doubled - 9
              true -> doubled
            end

          true ->
            n
        end
      end)
      |> Enum.sum()
      |> rem(10) == 0
    end
  end
end
