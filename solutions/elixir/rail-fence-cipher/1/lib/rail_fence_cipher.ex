defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()

  def encode(str, 1), do: str

  def encode(str, rails) do
    cond do
      String.graphemes(str) |> MapSet.new() |> Enum.count() < rails ->
        str

      true ->
        String.graphemes(str)
        |> Enum.with_index()
        |> Enum.map(fn {s, i} ->
          camels(s, i, rails)
        end)
        |> Enum.group_by(fn {i, _} -> i end, fn {_, v} -> v end)
        |> Enum.map(fn {_, v} -> v |> Enum.join() end)
        |> Enum.join()
    end
  end

  def camels(s, i, rails) do
    r = rails - 1
    d = div(i, r)

    cond do
      rem(d, 2) == 0 ->
        {rem(i, r), s}

      true ->
        {r - rem(i, r), s}
    end
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, rails) when rails > bit_size(str) / 8 or rails == 1, do: str

  def decode(str, rails) do
    str
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {s, i} ->
      {p, _} = camels(s, i, rails)
      {p, i}
    end)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
    |> Enum.zip(str |> String.graphemes())
    |> Enum.sort_by(&elem(&1, 0))
    |>Enum.map_join(&elem(&1,1))
  end
end
