defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    cond do
    Integer.gcd(a,26) != 1 -> {:error, "a and m must be coprime."}
    true -> {:ok,String.downcase(message) 
    |>String.replace(~r/[^a-z0-9]/,"")
    |> to_charlist
    |> Enum.map(fn x -> 
         cond do 
           x>=97 && x<=122 -> 97 + Integer.mod((x-97)*a+b,26)
           true -> x
         end
       end)
    |> Enum.chunk_every(5) 
    |> Enum.map(fn chunk -> chunk |> List.to_string end)
    |> Enum.join(" ")}
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do

  cond do
    Integer.gcd(a,26) != 1 -> {:error, "a and m must be coprime."}
    true -> {:ok, String.split(encrypted," ")
     |> Enum.join
     |> to_charlist
     |> Enum.map(fn x -> 
       cond do
         x>=97 && x<=122 -> 97 + Integer.mod(Integer.pow(a,11)*(x-97-b),26)
         true -> x
       end
     end)
     |> List.to_string
    }
    end
  end
end
