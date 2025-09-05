defmodule MatchingBrackets do
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string) do
    is_balanced?(to_charlist(string), [])
  end

  defp is_balanced?([], []), do: true
  defp is_balanced?([41], []), do: false
  defp is_balanced?([93], []), do: false
  defp is_balanced?([125], []), do: false
  defp is_balanced?([], _l), do: false

  defp is_balanced?([h_src | t_src] = input, list) do
    IO.inspect(input, label: "list")
    IO.inspect(list, label: "stack")

    cond do
      list == [] and (h_src == 41 or h_src == 93 or h_src == 125) ->
        false

      h_src == 40 or h_src == 91 or h_src == 123 ->
        is_balanced?(t_src, [h_src | list])

      (h_src == 41 && hd(list) == 40) or
        (h_src == 93 && hd(list) == 91) or
          (h_src == 125 && hd(list) == 123) ->
        is_balanced?(t_src, tl(list))

      (h_src == 125 and hd(list) != 123) or
        (h_src == 93 and hd(list) != 91) or
          (h_src == 41 and hd(list) != 40) ->
        false

      true ->
        is_balanced?(t_src, list)
    end
  end
end
