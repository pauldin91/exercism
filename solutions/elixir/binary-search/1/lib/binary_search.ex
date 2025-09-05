defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
      li = numbers |>Tuple.to_list()
      binsearch(li,0,Enum.count(li),key)
  end
  
  defp binsearch(_numbers, left, right, _key) when left > right, do: :not_found

  defp binsearch(numbers, left, right, key) do
    middle = div(left + right, 2)

    pivot = Enum.at(numbers, middle)

    cond do
      pivot == key -> {:ok, middle}
      pivot > key -> binsearch(numbers, left, middle - 1, key)
      pivot < key -> binsearch(numbers, middle + 1, right, key)
    end
  end
  
end
