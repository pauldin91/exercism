defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    dist = distance({x,y})
    cond do
      dist>10->0
      dist>5 && dist<=10 -> 1
      dist<=5 && dist>1 ->5
      dist<=1->10
      true -> 0
    end
  end


  def distance({x,y}) do
    :math.sqrt(x*x+y*y)
  end
end
