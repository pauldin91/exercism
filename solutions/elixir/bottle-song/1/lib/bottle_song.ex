defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """
  @num_to_word %{
    0 => "no",
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down)
      when start_bottle < 1 or start_bottle > 10 or take_down < 1,
      do: ""

  def recite(start_bottle, take_down)
      when start_bottle >= 1 and start_bottle <= 10 and take_down >= 1 do
    const =
      cond do
        start_bottle == 1 -> "green bottle hanging on the wall"
        true -> "green bottles hanging on the wall"
      end

    next =
      cond do
        start_bottle - 1 == 1 -> "green bottle hanging on the wall"
        true -> "green bottles hanging on the wall"
      end

    first = "#{@num_to_word[start_bottle]} #{const},"

    result =
      Enum.join(
        [
          first,
          first,
          "And if one green bottle should accidentally fall,",
          "There'll be #{@num_to_word[start_bottle - 1] |> String.downcase()} #{next}.\n"
        ],
        "\n"
      )

    # cond do
    #   take_down >= 1 ->
    #     result <> "\n" <> recite(start_bottle - 1, take_down - 1) |> String.trim

    #   true ->
    (result <> "\n" <> recite(start_bottle - 1, take_down - 1)) |> String.trim()
    # end
  end
end
