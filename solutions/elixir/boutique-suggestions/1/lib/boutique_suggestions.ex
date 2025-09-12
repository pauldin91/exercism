defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ []) do
    max_price = Keyword.get(opts, :maximum_price, 100.0)

    for t <- tops, b <- bottoms do
      {t, b}
    end 
    |>
    Enum.filter(fn {t,b} -> 
        t.base_color != b.base_color &&
        t.price + b.price <= max_price end)
  end
end
