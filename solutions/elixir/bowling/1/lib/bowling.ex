defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  defstruct [:buffer, :counter]
  @spec start() :: any
  def start do
    {:ok, %Bowling{buffer: [], counter: 0}}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """
  @spec roll(any, integer) :: {:ok, any} | {:error, String.t()}
  def roll(game, roll) do
    cond do
      game.counter >= 10 ->
        {:error, "game over"}

      roll >= 0 and roll <= 10 ->
        handle(game, roll)

      true ->
        {:error, "invalid pin number"}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}
  def score(game) do
    cond do
      game.counter == 10 ->
        record =
          Map.new(
            Enum.zip(
              1..10,
              Enum.reverse(game.buffer)
              |> Enum.map(fn e ->
                {e |> Tuple.to_list() |> Enum.sum(), e |> Tuple.to_list() |> Enum.count() == 2}
              end)
            )
          )

        1..10
        |> Enum.reduce(0, fn x, acc ->
          calculate(record, x, acc)
        end)

      true ->
        {:error, "Game not over"}
    end
  end

  def calculate(record, x, acc) do
    value = Map.get(record, x, 0)
    next = elem(Map.get(record, x + 1, {0, 0}), 0)
    next_to_next = elem(Map.get(record, x + 2, {0, 0}), 0)

    case value do
      {10, false} -> acc + 10 + next + next_to_next
      {10, true} -> acc + 10 + next
      _ -> acc + elem(value, 0)
    end
  end

  defp handle(%Bowling{buffer: []}, roll), do: {:ok, %Bowling{buffer: [{roll}], counter: 0}}

  defp handle(%Bowling{buffer: [{_h1, _h2} | _]} = frames, roll),
    do: {:ok, %Bowling{buffer: [{roll} | frames.buffer], counter: frames.counter}}

  defp handle(%Bowling{buffer: [{0} | t]} = frames, roll = 10),
    do: {:ok, %Bowling{buffer: [{0, roll} | t], counter: frames.counter + 1}}

  defp handle(%Bowling{} = frames, roll = 10),
    do: {:ok, %Bowling{buffer: [{roll} | frames.buffer], counter: frames.counter + 1}}

  defp handle(%Bowling{buffer: [{10} | _]} = frames, roll),
    do: {:ok, %Bowling{buffer: [{roll} | frames.buffer], counter: frames.counter}}

  defp handle(%Bowling{buffer: [{h} | _]} = _, roll) when h + roll > 10,
    do: {:error, "invalid pin number"}

  defp handle(%Bowling{buffer: [{h} | t]} = frames, roll)
       when roll < 10 and h < 10 and h + roll <= 10,
       do: {:ok, %Bowling{buffer: [{h, roll} | t], counter: frames.counter + 1}}
end
