defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    String.first(String.trim_leading(name))
  end

  def initial(name) do
    # Please implement the initial/1 function
    String.upcase(first_letter(name)) <> "."
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    name = String.split(full_name)
    initial(hd(name))<>" "<>initial(hd(tl(name)))
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤
    "❤-------------------❤\n|  "<>initials(full_name1) <> "  +  " <> initials(full_name2) <> "  |\n❤-------------------❤\n"
    # Please implement the pair/2 function
  end
end
