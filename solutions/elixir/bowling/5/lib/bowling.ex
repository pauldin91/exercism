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
      gameover?(game) ->
        {:error, "Cannot roll after game is over"}

      true ->
        handle(game, roll)
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """
  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    cond do
      gameover?(game) ->
        record = get_records(game)

        normal_frames =
          1..Enum.count(game)
          |> Enum.reduce(0, fn x, acc ->
            calculate(record, x, acc)
          end)

        {:ok, normal_frames}

      true ->
        {:error, "Score cannot be taken until the end of the game"}
    end
  end

  defp gameover?([]), do: false
  defp gameover?([_]), do: false

  defp gameover?([h | _] = game) do
    count = Enum.count(game)
    ordered = Enum.reverse(game)
    tenth = Enum.at(ordered, 9)
    eleventh = Enum.at(ordered, 10)

    tenth_strike = strike?(tenth)

    cond do
      count == 12 and tenth_strike and strike?(eleventh) ->
        true

      count == 11 and tenth_strike and Enum.count(h) == 2 ->
        true

      count == 11 and spare?(tenth) ->
        true

      count == 10 and Enum.count(h) == 2 and open?(h) ->
        true

      true ->
        false
    end
  end

  defp bonus(record, x) do
    current = Map.get(record, x, [0, 0])
    next = Map.get(record, x + 1, [0, 0])
    after_next = Map.get(record, x + 2, [0, 0])
    s = Enum.sum(current)
    ns = Enum.sum(next)

    cond do
      strike?(current) and strike?(next) ->
        s + ns + Enum.at(after_next, 0)

      strike?(current) ->
        s + ns

      spare?(current) ->
        s + Enum.at(next, 0)

      true ->
        s
    end
  end

  defp calculate(record, x, acc) do
    acc +
      cond do
        x < 10 ->
          bonus(record, x)

        true ->
          Map.get(record, x, [0, 0]) |> Enum.sum()
      end
  end

  defp get_records(game),
    do:
      Map.new(
        Enum.zip(
          1..Enum.count(game),
          Enum.reverse(game)
        )
      )

  defp strike?(current) do
    current == [10] or current == [0, 10]
  end

  defp spare?(current) do
    Enum.sum(current) == 10 and !strike?(current)
  end

  defp open?(current) do
    Enum.sum(current) < 10
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
