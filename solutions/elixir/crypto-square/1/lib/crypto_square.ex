defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do

    clean=str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")

    cond do 
      clean=="" -> ""
      true ->
    s = ceil(:math.sqrt(clean |> String.length()))
    
    clean|> String.graphemes()
    |> Enum.chunk_every(s)
    |> Enum.map(fn arr ->
      arr
      |> Enum.join()
      |> String.pad_trailing(s, " ")
      |> String.graphemes()
    end)
    |> Enum.join()
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.group_by(fn {_, i} -> rem(i, s) end, fn {k, _} -> k end)
    |> Enum.map(fn {_k, v} -> v |> Enum.join() end)
    |> Enum.join(" ")
    
    end
  end
end
