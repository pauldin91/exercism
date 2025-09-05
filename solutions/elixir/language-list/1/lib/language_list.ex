defmodule LanguageList do
  def new() do
    # Please implement the new/0 function
    []
  end

  def add(list, language) do
    # Please implement the add/2 function
    [language]++list
  end

  def remove(list) do
    # Please implement the remove/1 function
    tl(list) 
  end

  def first(list) do
    # Please implement the first/1 function
    hd(list) 
  end

  def count([_h|t]) do
    # Please implement the count/1 function
    
    cond do 
    t==[] -> 1
    true -> 1+count(t)
    end
  end
  def count([])do
    0
  end

  def functional_list?([head|tail]) do
    # Please implement the functional_list?/1 function
    cond do
      head=="Elixir" -> true
      head==nil->false
      true->functional_list?(tail)
    end
    
  end
  def functional_list?([])do
    nil
  end
end
