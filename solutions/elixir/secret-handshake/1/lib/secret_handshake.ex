defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    s =
      Integer.to_string(code, 2)
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn kv -> action(kv) end)

    cond do
      Enum.any?(s, fn c -> c == "reverse" end) ->
        Enum.take_while(s, fn x -> x != "reverse" end)
        |> Enum.reverse()
        |> Enum.filter(fn c -> c != "" end)

      true ->
        s |> Enum.filter(fn c -> c != "" end)
    end
  end

  def action({val, index}) do
    cond do
      index == 0 && val == "1" -> "wink"
      index == 1 && val == "1" -> "double blink"
      index == 2 && val == "1" -> "close your eyes"
      index == 3 && val == "1" -> "jump"
      index == 4 && val == "1" -> "reverse"
      true -> ""
    end
  end
end
