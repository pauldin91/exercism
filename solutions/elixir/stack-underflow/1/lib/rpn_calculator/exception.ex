defmodule RPNCalculator.Exception do

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        context when is_binary(context) ->
          %StackUnderflowError{message: "stack underflow occurred, context: #{context}"}
      end
    end
  end

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %DivisionByZeroError{}

        msg when is_binary(msg) ->
          %DivisionByZeroError{message: msg}
      end
    end
  end

  def divide([]) , do: raise %StackUnderflowError{message: "stack underflow occurred, context: when dividing"}
  def divide([h|t]) do
    cond do
      Enum.count(t) == 0 ->  raise %StackUnderflowError{message: "stack underflow occurred, context: when dividing"}
      Enum.count(t) == 1 && h != 0 -> hd(t)/h 
      true -> raise %DivisionByZeroError{message: "division by zero occurred"} 
    end 
  end
end
