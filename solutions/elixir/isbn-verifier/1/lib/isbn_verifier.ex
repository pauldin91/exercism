defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    trim = String.split(isbn, "-") |> Enum.join()

    cond do
      Regex.match?(~r/^(?:[0-9]{10}|[0-9]{9}X)$/, trim) ->
        String.graphemes(trim)
        |> Enum.with_index()
        |> Enum.reduce(0, fn {n, i}, acc ->
          cond do
            n == "X" -> acc + 10
            true -> String.to_integer(n) * (10 - i) + acc
          end
        end)
        |> Integer.mod(11) == 0

      true ->
        false
    end
  end
end
