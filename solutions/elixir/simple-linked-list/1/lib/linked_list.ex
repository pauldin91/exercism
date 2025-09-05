defmodule LinkedList do
  @opaque t :: {any(), t} | {nil, nil}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new, do: {nil, nil}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({nil, nil}, elem), do: {elem, {nil, nil}}
  def push(list, elem), do: {elem, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count({nil, nil}), do: 0
  def count({_val, next}), do: 1 + count(next)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil, nil}), do: {:error, :empty_list}
  def peek({val, _}), do: {:ok, val}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil, nil}), do: {:error, :empty_list}
  def tail({_val, next}), do: {:ok, next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil, nil}), do: {:error, :empty_list}
  def pop({val, next}), do: {:ok, val, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: new()
  def from_list([h | t]), do: push(from_list(t), h)

  @doc """
  Construct a stdlib List from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({nil, nil}), do: []
  def to_list({val, next}), do: [val | to_list(next)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, new())

  defp do_reverse({nil, nil}, acc), do: acc
  defp do_reverse({val, next}, acc), do: do_reverse(next, push(acc, val))
end
