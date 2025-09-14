defmodule RPG do
  defprotocol Edible do
    def eat(item, char)
  end

  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defimpl Edible, for: LoafOfBread do
    alias RPG.Character

    def eat(_, char) do
      {nil, %Character{health: char.health + 5, mana: char.mana}}
    end
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defimpl Edible, for: ManaPotion do
    alias RPG.Character

    def eat(item, char) do
      {%EmptyBottle{}, %Character{health: char.health, mana: char.mana + item.strength}}
    end
  end

  defimpl Edible, for: Poison do
    alias RPG.Character

    def eat(_, char) do
      {%EmptyBottle{}, %Character{health: 0, mana: char.mana}}
    end
  end

  # Add code to define the protocol and its implementations below here...
end
