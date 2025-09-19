defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    # Please implement new_collection/1
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    # Please implement add_card/2
    cond do
      !MapSet.member?(collection,card) -> {false,MapSet.put(collection,card)}
      true -> {true,collection}
    end
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    # Please implement trade_card/3
    cond do
      
     !MapSet.member?(collection,their_card) -> {MapSet.member?(collection,your_card),MapSet.delete(collection,your_card) |> MapSet.put(their_card)}
      true -> {false,collection |> MapSet.delete(your_card)}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates([]), do: []
  def remove_duplicates(cards) do
    # Please implement remove_duplicates/1
    MapSet.new(cards) |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    # Please implement extra_cards/2
    MapSet.difference(your_collection, their_collection) |> Enum.count
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards(collection) do
    # Please implement boring_cards/1
    Enum.reduce(collection,fn x,acc -> MapSet.intersection(acc,x) end) |> MapSet.to_list
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards(collections) do
    # Please implement total_cards/1
    Enum.reduce(collections,&MapSet.union(&1,&2)) |> Enum.count
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    # Please implement split_shiny_cards/1
    {h1,h2} = collection |> MapSet.split_with(fn v -> v|>String.downcase|>String.contains?("shiny") end )
    {MapSet.to_list(h1),MapSet.to_list(h2)}
  end
end
