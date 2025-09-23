defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(fn c -> 
      cond do  
        c<= 90 && c>=65 -> 65 + rem(c-65+shift,26)
        c>=97 && c<=122 -> 97 + rem(c-97+shift,26) 
        true -> c 
      end
      end)
    |> List.to_string
    
  end
end
