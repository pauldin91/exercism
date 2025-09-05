defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    # Please implement the sort_by_price/1 function
    Enum.sort_by(inventory, fn s -> s.price end, :asc)
  end

  def with_missing_price(inventory) do
    # Please implement the with_missing_price/1 function
    Enum.filter(inventory, fn s -> s.price == nil end)
  end

  def update_names([], old_word, new_word), do: []

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn s ->
      cond do
        String.contains?(s.name, old_word) ->
          %{
            price: s[:price],
            name: String.replace(s[:name], old_word, new_word),
            quantity_by_size: s[:quantity_by_size]
          }

        true ->
          s
      end
    end)
  end

  def increase_quantity(nil, count), do: nil

  def increase_quantity(item, count) do
    cond do
      item[:quantity_by_size] != %{} ->
        %{
          price: item[:price],
          name: item[:name],
          quantity_by_size: %{
            s: inc(item[:quantity_by_size][:s], count),
            m: inc(item[:quantity_by_size][:m], count),
            l: inc(item[:quantity_by_size][:l], count),
            xl: inc(item[:quantity_by_size][:xl], count)
          }
        }

      true ->
        %{
          price: item[:price],
          name: item[:name],
          quantity_by_size: %{}
        }
    end
  end

  def inc(i, count) do
    cond do
      i == nil -> count
      true -> i + count
    end
  end

  def total_quantity(item) do
    cond do
      item[:quantity_by_size] != %{} -> item[:quantity_by_size][:s]+item[:quantity_by_size][:l]+item[:quantity_by_size][:m]+item[:quantity_by_size][:xl]
      true -> 0
    end
  end
end
