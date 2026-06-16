defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @heading_template "On the {day} day of Christmas my true love gave to me:"

  @numbered %{
    12 => "twelfth",
    11 => "eleventh",
    10 => "tenth",
    9 => "ninth",
    8 => "eighth",
    7 => "seventh",
    6 => "sixth",
    5 => "fifth",
    4 => "fourth",
    3 => "third",
    2 => "second",
    1 => "first"
  }

  @the_map %{
    12 => "twelve Drummers Drumming",
    11 => "eleven Pipers Piping",
    10 => "ten Lords-a-Leaping",
    9 => "nine Ladies Dancing",
    8 => "eight Maids-a-Milking",
    7 => "seven Swans-a-Swimming",
    6 => "six Geese-a-Laying",
    5 => "five Gold Rings",
    4 => "four Calling Birds",
    3 => "three French Hens",
    2 => "two Turtle Doves",
    1 => "and a Partridge in a Pear Tree."
  }

  def get_build(),
    do:
      @the_map
      |> Enum.map(& &1)
      |> Enum.sort(:desc)

  def get_heading(number) do
    verb = Map.get(@numbered, number, "")

    String.replace(
      @heading_template,
      "{day}",
      verb |> String.split(" ") |> Enum.at(0)
    )
  end

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    get_heading(number) <> " " <>
      cond do
        number == 1 ->
          Map.get(@the_map, number, "")
          |> String.replace("and ", "")

        true ->
          get_build()
          |> Enum.drop_while(fn {n, _theme} -> n != number end)
          |> Enum.map(&elem(&1, 1))
          |> Enum.join(", ")
      end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
