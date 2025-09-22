defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    res = normalize(base)

    candidates
    |> Enum.filter(fn word ->
      normalize(word) == res and String.downcase(base) != String.downcase(word)
    end)
  end

  def normalize(base),
    do: String.downcase(base) |> String.graphemes() |> Enum.sort() |> Enum.join()
end
