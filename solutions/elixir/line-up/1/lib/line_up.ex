defmodule LineUp do
  @endings %{
    "1" => "st",
    "2" => "nd",
    "3" => "rd",
    "11" => "th",
    "12" => "th",
    "13" => "th"
  }
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """

  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    s = to_string(number)
    suffix = get_suffix(s |> String.graphemes())

    cond do
      suffix != nil -> build_msg(name, s <> suffix)
      true -> build_msg(name, s <> "th")
    end
  end

  def get_suffix(nil), do: ""

  def get_suffix([h]), do: @endings[h]

  def get_suffix([_ | t] = s) do
    cond do
      length(s) == 2 && @endings[to_string(s)] != nil -> @endings[to_string(s)]
      length(t) == 2 && @endings[to_string(t)] != nil -> @endings[to_string(t)]
      true -> get_suffix(t)
    end
  end

  defp build_msg(name, number) do
    "#{name}, you are the #{number} customer we serve today. Thank you!"
  end
end
