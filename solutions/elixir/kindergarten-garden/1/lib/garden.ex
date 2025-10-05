defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @plants %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}
  @student_ids %{
    0 => :alice,
    1 => :bob,
    2 => :charlie,
    3 => :david,
    4 => :eve,
    5 => :fred,
    6 => :ginny,
    7 => :harriet,
    8 => :ileana,
    9 => :joseph,
    10 => :kincaid,
    11 => :larry
  }
  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ []) do
    students =
      cond do
        student_names != [] -> student_names |> Enum.sort()
        true -> @students
      end

    student_ids = Enum.with_index(students) |> Map.new(fn {s, i} -> {i, s} end)
    s = String.split(info_string, "\n")

    Enum.flat_map(s, fn line -> line |> String.graphemes() |> Enum.chunk_every(2) end)
    |> Enum.with_index()
    |> Enum.group_by(fn {_s, i} -> rem(i, div(String.length(hd(s)), 2)) end, fn {s, _i} -> s end)
    |> Enum.reduce(student_ids, fn s, acc ->
      Map.update(acc, elem(s, 0), {}, fn _ ->
        elem(s, 1)
        |> Enum.join()
        |> String.graphemes()
        |> Enum.map(&Map.get(@plants, &1))
        |> List.to_tuple()
      end)
    end)
    |> Map.merge(student_ids, fn _, v1, v2 ->
      cond do
        is_tuple(v1) -> {v2, v1}
        true -> {v2, {}}
      end
    end)
    |> Enum.map(fn {s, d} -> d end)
    # |> Enum.sort_by(fn {s, _} -> s end)
    |> Enum.into(%{})
  end
end
