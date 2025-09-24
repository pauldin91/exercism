defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()
  defstruct [:students]

  @doc """
  Create a new, empty school.
  """
  
  @spec new() :: school
  def new(), do: %School{students: []}

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    exists = school.students |> Enum.find(fn {n,_} -> name==n end)
    cond do
      exists==nil -> {:ok,%School{students: [{name,grade}|school.students]}}
      true -> {:error,school}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    Enum.filter(school.students,fn {n,g} -> g==grade end)
    |> Enum.map(fn {name,_}->name end)
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    Enum.sort_by(school.students,fn {name,grade} -> {grade,name} end)
    |> Enum.map(fn el -> elem(el,0) end) 
  end
end
