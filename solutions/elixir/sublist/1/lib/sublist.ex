defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list,
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      sublist_strict?(a, b) -> :sublist
      sublist_strict?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist_strict?([], _), do: true
  defp sublist_strict?(_, []), do: false
  defp sublist_strict?(a, b) when length(a) > length(b), do: false

  defp sublist_strict?(a, b) do
    if strict_prefix_match?(a, b) do
      true
    else
      sublist_strict?(a, tl(b))
    end
  end

  defp strict_prefix_match?([], _), do: true
  defp strict_prefix_match?(_, []), do: false
  defp strict_prefix_match?([ha | ta], [hb | tb]) when ha === hb, do: strict_prefix_match?(ta, tb)
  defp strict_prefix_match?(_, _), do: false
end
