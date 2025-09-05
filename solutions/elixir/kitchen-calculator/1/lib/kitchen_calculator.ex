defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    elem(volume_pair,1)
  end

  def to_milliliter(volume_pair) do
    # Please implement the to_milliliter/1 functions
    unit = elem(volume_pair,0)
    cond do
      unit==:cup -> {:milliliter,elem(volume_pair,1) *240} 
      unit==:milliliter -> volume_pair
      unit==:tablespoon ->{:milliliter,elem(volume_pair,1) * 15}
      unit==:fluid_ounce ->{:milliliter,elem(volume_pair,1) * 30}
      unit==:teaspoon -> {:milliliter,elem(volume_pair,1) * 5}
      true -> volume_pair
    end
  end

  def from_milliliter(volume_pair, unit) do
    # Please implement the from_milliliter/2 functions
    mls = elem(volume_pair,1)
    cond do
      unit==:cup -> {:cup,mls /240} 
      unit==:milliliter -> {:milliliter,mls }
      unit==:tablespoon -> {:tablespoon,mls / 15}
      unit==:fluid_ounce -> {:fluid_ounce,mls / 30}
      unit==:teaspoon -> {:teaspoon,mls / 5}
      true->volume_pair
    end
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    from_milliliter(to_milliliter(volume_pair),unit)
  end
end
