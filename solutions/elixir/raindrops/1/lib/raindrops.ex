defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    do_convert(number,"")
  end


  defp do_convert(number,str) do
      cond do
        rem(number,3)==0 and !String.ends_with?(str,"Pling")-> do_convert(div(number,3),str<>"Pling")
        rem(number,5)==0 and !String.ends_with?(str,"Plang") -> do_convert(div(number,5),str<>"Plang")
        rem(number,7)==0 and !String.ends_with?(str,"Plong") -> do_convert(div(number,7),str<>"Plong")
        str=="" -> Integer.to_string(number)
        true->str
      end
  end
end
