defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    # Please implement the extract_from_path/2 function
    [h|t] = String.split(path,".")
    cond do
      t != [] -> extract_from_path(data[h],Enum.join(t,"."))
      true -> data[h] 
    end
  end

  def get_in_path(data, path) do
    get_in(data,String.split(path,"."))
  end
end
