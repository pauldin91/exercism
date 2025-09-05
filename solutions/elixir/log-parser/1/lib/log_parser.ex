defmodule LogParser do
  def valid_line?(line) do
    # Please implement the valid_line?/1 function
    match = Regex.run(~r/((^\[)[A-Z]+\])/, line)

    if match == nil do
      false
    else
      f = hd(match)

      cond do
        length(match) == 0 -> false
        f == "[ERROR]" or f == "[INFO]" or f == "[DEBUG]" or f == "[WARNING]" -> true
        true -> false
      end
    end
  end

  def split_line(line) do
    String.split(line, ~r/<[~\*-=]*>/)
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
    String.replace(line,~r/[Ee][Nn][Dd]-[Oo][Ff]-[Ll][Ii][Nn][Ee][0-9]+/,"")
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
    r = Regex.run(~r/User(\s)+([\p{L}\p{N}_\p{S}!]+)/u, line)
    cond do
      r==nil -> line
      true -> "[USER] #{String.trim(String.replace(hd(r),"User",""))} "<> line
    end
  end
end
