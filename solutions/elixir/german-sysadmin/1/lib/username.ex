defmodule Username do
  def sanitize(username) do
    username
    |> to_charlist()
    |> Enum.map(&replace/1)
    |> List.flatten()
  end

  # Replace or keep allowed characters
  defp replace(?ä), do: 'ae'
  defp replace(?ö), do: 'oe'
  defp replace(?ü), do: 'ue'
  defp replace(?ß), do: 'ss'
  defp replace(ch) when ch in ?a..?z or ch == ?_, do: [ch]
  defp replace(_), do: []  # Remove everything else
end
