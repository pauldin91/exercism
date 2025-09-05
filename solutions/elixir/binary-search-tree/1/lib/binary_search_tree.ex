defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)

  def insert(%{data: node_data, left: left, right: right} = tree, data) do
    cond do
      node_data >= data -> %{data: node_data, left: insert(left, data), right: right}
      true -> %{data: node_data, left: left, right: insert(right, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []
  def in_order(%{data: node_data, left: nil, right: nil} = tree), do: [node_data]

  def in_order(%{data: node_data, left: left, right: right} = tree) do
    in_order(left) ++ [node_data] ++ in_order(right)
  end
end
