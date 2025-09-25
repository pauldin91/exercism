defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([h|_]=strings) do
    do_recite(strings,"") <> "And all for the want of a #{h}.\n"
  end
  def do_recite([],acc), do: acc
  def do_recite([h1],acc), do: acc
  def do_recite([h1,h2],acc), do: acc<>"For want of a #{h1} the #{h2} was lost.\n"
  def do_recite([h1,h2|t],acc) do
    do_recite([h2|t],acc<>"For want of a #{h1} the #{h2} was lost.\n")
  end
end
