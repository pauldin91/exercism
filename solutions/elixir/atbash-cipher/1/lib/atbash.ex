defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
  String.downcase(plaintext)
    |> to_charlist()
    |> Enum.map(fn c ->
      cond do
        c<=90 && c>=65 -> 65 + rem(90-c,26)
        c>=97 && c<=122 -> 97 + rem(122-c,26)
        c in ?0..?9 -> c
        true->''
      end
    end)
    |> List.to_string
    |> String.graphemes
    |> Enum.join
    |> String.graphemes
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    String.split(cipher," ")
    |> Enum.join
    |> to_charlist
    |> Enum.map(fn c ->
      cond do
        c<=90 && c>=65 -> 65 + rem(90-c,26)
        c>=97 && c<=122 -> 97 + rem(122-c,26)
        true -> c
      end
    end)
     |> List.to_string
    
  end
end
