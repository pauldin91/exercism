defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed = String.trim(to_string(input))

    cond do
      trimmed == "" ->
        "Fine. Be that way!"

      all_caps?(trimmed) and String.ends_with?(trimmed, "?") ->
        "Calm down, I know what I'm doing!"

      all_caps?(trimmed) ->
        "Whoa, chill out!"

      String.ends_with?(trimmed, "?") ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp all_caps?(line) do
    letters = Regex.scan(~r/\p{L}/u, line) |> List.flatten() |> Enum.join()

    letters != "" and String.upcase(letters) == letters
  end
end
