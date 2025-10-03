defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""

  def transpose(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> List.foldr([], &zip/2)
    |> Enum.join("\n")
  end

  def zip([], []), do: []
  def zip([], [ch | rest]), do: [" " <> ch | zip([], rest)]
  def zip([ch | rest], []), do: [ch | zip(rest, [])]
  def zip([ch1 | rest1], [ch2 | rest2]), do: [ch1 <> ch2 | zip(rest1, rest2)]
end
