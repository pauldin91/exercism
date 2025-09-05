defmodule NameBadge do
  def print(id, name, department) do
    # Please implement the print/3 function
    st = (if id != nil, do: "[" <> Integer.to_string(id) <> "] - " ,else: "") <>
     name <> " - " <>
    (if department != nil, do: String.upcase(department), else: "OWNER")
    st
  end
end
