defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.split(String.downcase(sentence),~r/[^a-z0-9']+/,trim: true) 
    |> Enum.map(fn word -> String.trim(word,"'")end)
    |> Enum.frequencies
  end
end
