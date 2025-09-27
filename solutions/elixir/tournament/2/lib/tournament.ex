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
  @points %{"W" => 3, "L" => 0, "D" => 1}
  def tally(input) do
    headers =
      """
      Team                           | MP |  W |  D |  L |  P
      """

    result =
      do_tally(input, %{})
      |> Map.to_list()
      |> Enum.sort_by(fn {_, score} -> Map.get(score, "P") end, :desc)

    do_format(result, headers) |> String.trim("\n")
  end

  def do_format([], headers), do: headers

  def do_format([{name, score} | t], headers) do
    do_format(
      t,
      headers <>
        name <>
        String.duplicate(" ", 31 - String.length(name)) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "MP", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "W", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "D", 0)} ", 4) <>
        "|" <>
        String.pad_leading("#{Map.get(score, "L", 0)} ", 4) <>
        "|" <> String.pad_leading("#{Map.get(score, "P", 0)}\n", 4)
    )
  end

  def do_tally([], result), do: result

  def do_tally([h | t], result) do
    outcome = String.split(h, ";")

    cond do
      Enum.count(outcome) != 3 ->
        do_tally(t, result)

      Enum.at(outcome, 2) == "win" ->
        result = update_values(outcome, 0, result)
        do_tally(t, result)

      Enum.at(outcome, 2) == "draw" ->
        result = update_values(outcome, -1, result)
        do_tally(t, result)

      Enum.at(outcome, 2) == "loss" ->
        result = update_values(outcome, 1, result)
        do_tally(t, result)

      true ->
        do_tally(t, result)
    end
  end

  def update_values(outcome, win_team, result) do
    cond do
      win_team == -1 ->
        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, 0), fn score ->
            update_score(score, "D")
          end)

        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, 1), fn score ->
            update_score(score, "D")
          end)

        result

      true ->
        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, win_team), fn score ->
            update_score(score, "W")
          end)

        {_, result} =
          Map.get_and_update(result, Enum.at(outcome, rem(win_team + 1, 2)), fn score ->
            update_score(score, "L")
          end)

        result
    end
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
    outcome = Map.get(score, key, 0)
    {key, inc.(outcome)}
  end
end
