defmodule Prime do
  @moduledoc """
  What I learned in this exercise.
  - there are more efficent ways to do this than the sieve of erasthenes
  """

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(DivisionByZeroError)

  def nth(count) do
    # Stream is really efficient and I could have done
    # Stream.iterate(2, &(&1 + 1)) but that includes evens
    # which after 2, are  never prime so instead I've done
    # something a bit ugly, were we generate a stream from three
    # and concatenate that onto a stream starting with 2.
    Stream.concat([2], Stream.iterate(3, &(&1 + 2)))
    |> Stream.filter(&prime?/1)
    |> Enum.at(count - 1)
  end

  defp prime?(n) when n < 2, do: false
  defp prime?(2), do: true
  defp prime?(3), do: true

  defp prime?(n) do
    2..floor(:math.sqrt(n))
    # we only want n's that are divisble by itself
    |> Enum.all?(fn divisor -> rem(n, divisor) != 0 end)
  end
end

defmodule DivisionByZeroError do
  defexception message: "division by zero occurred"
end
