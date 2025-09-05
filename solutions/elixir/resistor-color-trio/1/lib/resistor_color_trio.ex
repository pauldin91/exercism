defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([h | t]) when length([h | t]) > 0 do
    shift = color_to_number(h)*10 + color_to_number(hd(t))
    power = color_to_number(hd(tl(t)))
    
    last = trunc(:math.pow(10, power))
    result = shift * last

    cond do
      result < 1000 -> {result, :ohms}
      result >= 1000 && result < 1_000_000 -> {div(result, 1000), :kiloohms}
      result >= 1_000_000 && result < 1_000_000_000 -> {div(result, 1_000_000), :megaohms}
      true -> {div(result, 1_000_000_000), :gigaohms}
    end
  end

  def color_to_number(c) when c == :black, do: 0
  def color_to_number(c) when c == :brown, do: 1
  def color_to_number(c) when c == :red, do: 2
  def color_to_number(c) when c == :orange, do: 3
  def color_to_number(c) when c == :yellow, do: 4
  def color_to_number(c) when c == :green, do: 5
  def color_to_number(c) when c == :blue, do: 6
  def color_to_number(c) when c == :violet, do: 7
  def color_to_number(c) when c == :grey, do: 8
  def color_to_number(c) when c == :white, do: 9
end
