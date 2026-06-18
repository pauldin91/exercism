defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start, do: []

  def roll_reduce(game, rolls) do
    Enum.reduce(rolls, game, fn roll, game ->
      {:ok, game} = Bowling.roll(game, roll)
      game
    end)
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """
  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}

  def roll(_, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_, roll) when roll > 10, do: {:error, "Pin count exceeds pins on the lane"}

  def roll([[h] | _], roll) when h < 10 and h + roll > 10,
    do: {:error, "Pin count exceeds pins on the lane"}

  def roll(game, roll) do
    cond do
      is_gameover?(game) ->
        {:error, "Cannot roll after game is over"}

      true ->
        handle(game, roll)
    end
  end

  def is_gameover?([]), do: false
  def is_gameover?([_h]), do: false

  def is_gameover?([h | _] = game) do
    count = Enum.count(game)

    cond do
      count < 10 -> false
      count == 10 and Enum.sum(h) == 10 -> false
      count == 10 and Enum.sum(h) < 10 and Enum.count(h) < 2 -> false
      count == 10 and Enum.sum(h) < 10 and Enum.count(h) == 2 -> true
      count > 10 and count < 12 and Enum.sum(h) == 10 -> false
      true -> true
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """
  def get_records(game),
    do:
      Map.new(
        Enum.zip(
          1..Enum.count(game),
          Enum.reverse(game)
        )
      )

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    cond do
      is_gameover?(game) ->
        record = get_records(game)

        normal_frames =
          1..Enum.count(game)
          |> Enum.reduce(0, fn x, acc ->
            calculate(record, x, acc)
          end)

        special_frame = 0

        {:ok, normal_frames + special_frame}

      true ->
        {:error, "Score cannot be taken until the end of the game"}
    end
  end

  def bonus(current, next, after_next) do
    s = Enum.sum(current)
    ns = Enum.sum(next)
    dbg(current)
    dbg(s)
    dbg(next)
    dbg(ns)

    result =
      cond do
        (current == [10] or current == [0, 10]) and (next == [10] or next == [0, 10]) ->
          s + ns + Enum.at(after_next, 0)

        current == [10] or current == [0, 10] ->
          s + ns

        s == 10 ->
          s + Enum.at(next, 0)

        true ->
          s
      end

    dbg(result)
    result
  end

  def calculate(record, x, acc) do
    acc +
      cond do
        x < 10 ->
          bonus(
            Map.get(record, x, [0, 0]),
            Map.get(record, x + 1, [0, 0]),
            Map.get(record, x + 2, [0, 0])
          )

        true ->
          Map.get(record, x, [0, 0]) |> Enum.sum()
      end
  end

  defp handle([], roll), do: {:ok, [[roll]]}
  defp handle([h], roll) when h + roll <= 10, do: {:ok, [[h, roll]]}
  defp handle([[0] | t], roll = 10), do: {:ok, [[0, roll] | t]}
  defp handle(frames, roll = 10), do: {:ok, [[roll] | frames]}
  defp handle([[10] | _] = frames, roll), do: {:ok, [[roll] | frames]}
  defp handle([[h] | t], roll) when h + roll <= 10, do: {:ok, [[h, roll] | t]}
  defp handle([[_h1, _h2] | _] = frames, roll), do: {:ok, [[roll] | frames]}

  defp handle([[h] | _] = _, roll) when h + roll > 10,
    do: {:error, "Pin count exceeds pins on the lane"}
end
