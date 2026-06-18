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
  def roll(game, roll) do
    cond do
      roll < 0 ->
        {:error, "Negative roll is invalid"}

      roll >= 11 ->
        {:error, "Pin count exceeds pins on the lane"}

      Enum.count(game) >= 10 and hd(game) |> Tuple.to_list() |> Enum.sum() < 10 ->
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
      Enum.count(game) == 10 ->
        record =
          Map.new(
            Enum.zip(
              1..10,
              Enum.reverse(game)
            )
          )

        {:ok,
         1..10
         |> Enum.reduce(0, fn x, acc ->
           calculate(record, x, acc)
         end)}

      true ->
        {:error, "Score cannot be taken until the end of the game"}
    end
  end

  def bonus(current, next, after_next) do
    s = current |> Tuple.to_list() |> Enum.sum()
    ns = next |> Tuple.to_list() |> Enum.sum()

    cond do
      (current == {10} or current == {0, 10}) && (next == {10} or next == {0, 10}) ->
        20 + elem(after_next, 0)

      current == {10} or current == {0, 10} ->
        10 + ns

      s == 10 ->
        s + elem(next, 0)

      true ->
        s
    end
  end

  def calculate(record, x, acc) do
    acc +
      bonus(
        Map.get(record, x, {0, 0}),
        Map.get(record, x + 1, {0, 0}),
        Map.get(record, x + 2, {0, 0})
      )
  end

  defp handle([], roll), do: {:ok, [{roll}]}
  defp handle([{_h1, _h2} | _] = frames, roll), do: {:ok, [{roll} | frames]}
  defp handle([{0} | t], roll = 10), do: {:ok, [{0, roll} | t]}
  defp handle(frames, roll = 10), do: {:ok, [{roll} | frames]}
  defp handle([{10} | _] = frames, roll), do: {:ok, [{roll} | frames]}

  defp handle([{h} | t], roll) when roll < 10 and h < 10 and h + roll <= 10,
    do: {:ok, [{h, roll} | t]}

  defp handle([{h} | _] = _, roll) when h + roll > 10,
    do: {:error, "Pin count exceeds pins on the lane"}
end
