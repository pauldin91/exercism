defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    String.split(word, ~r/[^A-Za-z]/, trim: true)
    |> Enum.join()
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(fn c -> points(c) end)
    |> Enum.sum()
  end

  defp points(c) do
    cond do
      ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] |> MapSet.new() |> MapSet.member?(c) ->
        1

      c == "D" or c == "G" ->
        2

      ["B", "C", "M", "P"] |> MapSet.new() |> MapSet.member?(c) ->
        3

      ["F", "H", "V", "W", "Y"] |> MapSet.new() |> MapSet.member?(c) ->
        4

      c == "K" ->
        5

      c == "J" or c == "X" ->
        8

      c == "Q" or c == "Z" ->
        10

      true ->
        0
    end
  end
end
