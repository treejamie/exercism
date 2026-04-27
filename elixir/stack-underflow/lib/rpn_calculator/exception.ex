defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) when is_binary(value) do
      %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
    end

    def exception(_), do: %StackUnderflowError{}
  end

  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _]), do: raise(%DivisionByZeroError{})
  def divide([divisor, dividend]), do: dividend / divisor
end
