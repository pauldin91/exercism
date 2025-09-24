defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(""), do: true
  def isogram?(sentence) do
      t= 
      String.downcase(sentence)
      |>String.graphemes()
      |> Enum.frequencies()
      |> Enum.any?(fn {c,n} -> c != " " && c != "-" && n>1 end)
      !t
  end
end
