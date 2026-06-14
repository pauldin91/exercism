defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{x, y}]), do: x == y

  def chain?([{hx, hy} | dominoes]) do
    Enum.any?(
      dominoes,
      fn
        {^hx, x} = domino -> chain?([{hy, x} | List.delete(dominoes, domino)])
        {x, ^hx} = domino -> chain?([{hy, x} | List.delete(dominoes, domino)])
        _ -> false
      end
    )
  end
end
