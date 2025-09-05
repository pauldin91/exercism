defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count([h | t]) do
    1 + count(t)
  end

  @spec reverse(list) :: list
  def reverse(list) do
    do_reverse(list, [])
  end

  def do_reverse([], list), do: list
  def do_reverse([h | t], rev), do: do_reverse(t, [h | rev])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []

  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []

  def filter([h | t], f) do
    cond do
      f.(h) -> [h | filter(t, f)]
      true -> filter(t, f)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, f), do: acc

  def foldl([h | t], acc, f) do
    foldl(t, f.(h, acc), f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, f), do: acc

  def foldr(list, acc, f) do
    foldl(reverse(list),acc,f)
  end

  @spec append(list, list) :: list
  def do_append([], [], list), do: list
  def do_append([], [hb | tb] = b, list), do: do_append([], tb, [hb | list])
  def do_append([ha | ta] = a, [], list), do: do_append(ta, [], [ha | list])

  def do_append([ha | ta] = a, [hb | tb] = b, list) do
    cond do
      a != [] -> do_append(ta, b, [ha | list])
      b != [] -> do_append([], tb, [hb | list])
      true -> list
    end
  end

  def append(a, b) do
    reverse(do_append(a, b, []))
  end
  
  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(list) do
    do_concat(list,[])
  end

  def do_concat([],list), do: list
  def do_concat([h|t],list) do
    do_concat(t,append(list,h))
  end
end
