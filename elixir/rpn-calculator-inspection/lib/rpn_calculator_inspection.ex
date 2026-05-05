defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{
      pid: spawn_link(fn -> calculator.(input) end),
      input: input
    }
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    inputs
    |> Enum.reduce(%{}, fn input, results ->
      Process.flag(:trap_exit, true)

      result =
        start_reliability_check(calculator, input)
        |> await_reliability_check_result(results)

      Process.flag(:trap_exit, false)
      result
    end)
  end

  def correctness_check(calculator, inputs) do
    # Please implement the correctness_check/2 function
  end
end
