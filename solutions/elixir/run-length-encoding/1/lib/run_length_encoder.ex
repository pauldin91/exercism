defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(string) do
    do_encode(String.graphemes(string), 0, "", []) |> Enum.join()
  end

  def do_encode([], times, char, result), do: flush_letter(result, times, char)

  def do_encode([h | t], times, char, result) do
    cond do
      Regex.match?(~r/\s*[^a-zA-Z\s]{1}\s*/, h) ->
        do_encode(t, 0, "", flush_letter(result, times, char) ++ [h])

      h != char ->
        do_encode(t, 1, h, flush_letter(result, times, char))

      true ->
        do_encode(t, times + 1, char, result)
    end
  end

  def flush_letter(string, times, char) do
    cond do
      times == 1 -> string ++ [char]
      times > 1 -> string ++ [Integer.to_string(times) <> char]
      true -> string
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    do_decode(
      Regex.scan(
        ~r/\.*[0-9]{0,2}[a-zA-Z\s]{1}\.*/,
        string
      )
      |> Enum.map(fn c -> hd(c) end),
      []
    )
    |> Enum.join()
  end

  def do_decode([], res), do: res

  def do_decode([h | t], res) do
    s =
      Regex.named_captures(
        ~r/(?<space_before>\s*)(?<times>[0-9]{0,2})(?<letter>[a-zA-Z\s]{1})(?<space_after>\s*)/,
        h
      )

    letter = Map.get(s, "letter")
    times = Map.get(s, "times")
    space_before = Map.get(s, "space_before", "")
    space_after = Map.get(s, "space_after", "")

    cond do
      String.trim(times) == "" ->
        do_decode(t, res ++ [space_before <> letter <> space_after])

      true ->
        do_decode(
          t,
          res ++
            [
              space_before <>
                String.duplicate(letter, String.to_integer(String.trim(times))) <>
                space_after
            ]
        )
    end
  end
end
