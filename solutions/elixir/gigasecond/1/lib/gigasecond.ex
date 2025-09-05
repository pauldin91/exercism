defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
     {_,born} = NaiveDateTime.from_erl({{year, month, day}, {hours, minutes, seconds}})
     s = NaiveDateTime.add(born,1_000_000_000,:second)
     {{s.year,s.month,s.day},{s.hour,s.minute,s.second}}
  end
end
