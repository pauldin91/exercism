defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string 
    |> String.split(~r/[^A-Za-z']+/,trim: true) |> Enum.map(fn chunk -> chunk|> String.graphemes|> hd |> String.upcase  end) |> Enum.join
  end
end
