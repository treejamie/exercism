defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.flat_map(&factors(&1, limit))
    |> Enum.uniq()
    |> Enum.reduce(0, &+/2)
  end

  defp factors(0, _), do: []

  defp factors(factor, limit) do
    Range.new(1, limit - 1, 1)
    |> Enum.filter(fn n -> rem(n, factor) == 0 end)
  end
end
