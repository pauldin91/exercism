defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  defstruct [:map]

  def new([]), do: %CustomSet{}

  def new(enumerable) do
    %CustomSet{map: Map.new(enumerable, fn x -> {x, x} end)}
  end

  @spec empty?(t) :: boolean
  def empty?(%CustomSet{map: nil}), do: true
  def empty?(%CustomSet{map: _map}), do: false

  def contains?(%CustomSet{map: nil}, _element), do: false

  def contains?(%CustomSet{map: map}, element) do
    Map.get(map, element) != nil
  end

  @spec subset?(t, t) :: boolean

  def subset?(%CustomSet{map: nil}, %CustomSet{map: nil}), do: true
  def subset?(%CustomSet{map: nil}, %CustomSet{map: _map_2}), do: true
  def subset?(%CustomSet{map: _map_1}, %CustomSet{map: nil}), do: false

  def subset?(%CustomSet{map: map_1}, %CustomSet{map: map_2}) do
    Enum.all?(map_1, fn {k, _v} -> Map.get(map_2, k) != nil end)
  end

  @spec disjoint?(t, t) :: boolean

  def disjoint?(%CustomSet{map: nil}, %CustomSet{map: nil}), do: true
  def disjoint?(%CustomSet{map: nil}, %CustomSet{map: _non_empty}), do: true
  def disjoint?(%CustomSet{map: _non_empty}, %CustomSet{map: nil}), do: true

  def disjoint?(%CustomSet{map: map_1}, %CustomSet{map: map_2}) do
    Map.intersect(map_1, map_2) == Map.new()
  end

  @spec equal?(t, t) :: boolean
  def equal?(%CustomSet{map: nil}, %CustomSet{map: nil}), do: true
  def equal?(%CustomSet{map: nil}, %CustomSet{map: _non_empty}), do: false
  def equal?(%CustomSet{map: _non_empty}, %CustomSet{map: nil}), do: false

  def equal?(custom_set_1, custom_set_2) do
    subset?(custom_set_1, custom_set_2) and subset?(custom_set_2, custom_set_1)
  end

  @spec add(t, any) :: t
  def add(%CustomSet{map: nil}, element) do
    %CustomSet{map: %{element => element}}
  end

  def add(%CustomSet{map: map}, element) do
    %CustomSet{map: Map.put(map, element, element)}
  end

  @spec intersection(t, t) :: t
  def intersection(%CustomSet{map: nil}, %CustomSet{map: nil}), do: %CustomSet{map: nil}
  def intersection(%CustomSet{map: nil}, _non_empty), do: %CustomSet{map: nil}
  def intersection(_non_empty, %CustomSet{map: nil}), do: %CustomSet{map: nil}

  def intersection(custom_set_1, custom_set_2) do
    inter = Map.intersect(custom_set_1.map, custom_set_2.map)

    cond do
      inter == %{} -> %CustomSet{}
      true -> %CustomSet{map: inter}
    end
  end

  @spec difference(t, t) :: t
  def difference(%CustomSet{map: nil}, %CustomSet{map: nil}), do: %CustomSet{map: nil}
  def difference(%CustomSet{map: nil}, _non_empty), do: %CustomSet{}
  def difference(non_empty, %CustomSet{map: nil}), do: non_empty

  def difference(%CustomSet{map: map_1}, %CustomSet{map: map_2}) do
    diff = Map.filter(map_1, fn {k, _c} -> Map.get(map_2, k) == nil end)

    cond do
      diff == %{} -> %CustomSet{}
      true -> %CustomSet{map: diff}
    end
  end

  @spec union(t, t) :: t

  def union(%CustomSet{map: nil}, %CustomSet{map: nil}), do: %CustomSet{map: nil}
  def union(custom_set_1, %CustomSet{map: nil}), do: custom_set_1
  def union(%CustomSet{map: nil}, custom_set_2), do: custom_set_2

  def union(custom_set_1, custom_set_2) do
    %CustomSet{map: Map.merge(custom_set_1.map, custom_set_2.map)}
  end
end
