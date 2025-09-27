defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  @points %{"win" => 3, "loss" => 0, "draw" => 1}
  @rev_outcome %{"win" => "loss", "draw" => "draw", "loss" => "win"}
  def tally(input) do
    headers =
      """
      Team                           | MP |  W |  D |  L |  P
      """

    do_tally(input, %{})
    |> Map.to_list()
    |> Enum.sort_by(fn {_, score} -> Map.get(score, "P") end, :desc)
    |> do_format(headers)
    |> String.trim("\n")
  end

  def do_format([], headers), do: headers

  def do_format([{name, score} | t], headers) do
    do_format(
      t,
      headers <>
        String.pad_trailing(name, 31) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "MP", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "win", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "draw", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "loss", 0)} ", 4) <>
        "|" <> String.pad_leading("#{Map.get(score, "P", 0)}\n", 4)
    )
  end

  def do_tally([], result), do: result

  def do_tally([h | t], result) do
    outcome = String.split(h, ";")

    cond do
      Enum.count(outcome) != 3 ->
        do_tally(t, result)

      Map.get(@points, Enum.at(outcome, 2)) != nil ->
        do_tally(t, update_values(outcome, result))

      true ->
        do_tally(t, result)
    end
  end

  def update_values(input, result) do
    winner =
      cond do
        Enum.at(input, 2) == "win" -> {0, Enum.at(input, 2)}
        true -> {1, Map.get(@rev_outcome, Enum.at(input, 2))}
      end

    {_, result} =
      Map.get_and_update(result, Enum.at(input, elem(winner, 0)), fn score ->
        update_score(score, elem(winner, 1))
      end)

    {_, result} =
      Map.get_and_update(result, Enum.at(input, Integer.mod(elem(winner, 0) + 1, 2)), fn score ->
        update_score(score, Map.get(@rev_outcome, elem(winner, 1)))
      end)

    result
  end

  defp update_score(score, key) do
    scr =
      cond do
        score == nil ->
          %{key => 1}

        true ->
          {_, s} =
            Map.get_and_update(score, key, fn _ ->
              update_outcome(score, key)
            end)

          s
      end

    {_, scr} =
      Map.get_and_update(scr, "MP", fn _ ->
        update_outcome(scr, "MP")
      end)

    {_, scr} =
      Map.get_and_update(scr, "P", fn _ ->
        update_outcome(scr, "P", fn c -> c + Map.get(@points, key) end)
      end)

    {:score, scr}
  end

  defp update_outcome(score, key, inc \\ fn c -> c + 1 end) do
    points = Map.get(score, key, 0)
    {key, inc.(points)}
  end
end
