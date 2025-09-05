defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([h|t]) do
      get(h)*10+get(hd(t))
  end
  
  def get(colors) do
      cond do
      
      colors==:black -> 0
    colors==:brown -> 1
    colors==:red -> 2
    colors==:orange-> 3
    colors==:yellow-> 4
    colors==:green-> 5
    colors==:blue-> 6
    colors==:violet-> 7
    colors==:grey-> 8
    colors==:white-> 9
      end
  end
end
