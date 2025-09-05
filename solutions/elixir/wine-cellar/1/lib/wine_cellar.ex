defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(wines, color, opts \\ []) do
    year = Keyword.get(opts, :year)
    country = Keyword.get(opts, :country)

    wines
    |> Enum.filter(fn {wine_color, {_, wine_year, wine_country}} ->
      wine_color == color and
        (year == nil or wine_year == year) and
        (country == nil or wine_country == country)
    end)
    |> Enum.map(fn {_, wine_data} -> wine_data end)
  end

  defp match_year?(wine_year, opts) do
    case Keyword.get(opts, :year) do
      nil -> true
      filter_year -> wine_year == filter_year
    end
  end

  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, {_, year, _}} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([_ | tail], year), do: filter_by_year(tail, year)

  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, {_, _, country}} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([_ | tail], country), do: filter_by_country(tail, country)
end
