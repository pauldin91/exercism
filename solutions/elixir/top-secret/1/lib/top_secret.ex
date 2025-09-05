defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end
  
  def decode_secret_message(string) do
    ast = to_ast(string)
    {_ast, parts} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    Enum.reverse(parts) |> Enum.join()
  end

  def decode_secret_message_part({d, _,[{:when, _ , [{name,_,args},{cons,_,conditions}]},_] } = ast, acc) when is_atom(name) and (d==:def or d ==:defp) do
    arity = length(args || [])
    part = name |> Atom.to_string() |> String.slice(0, arity)
    {ast, [part | acc]}
  end
  
  def decode_secret_message_part({d, _, [{name, _, args} | _]} = ast, acc) when is_atom(name) and (d==:def or d ==:defp) do
    arity = length(args || [])
    part = name |> Atom.to_string() |> String.slice(0, arity)
    {ast, [part | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}
end
