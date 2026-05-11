defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @price 800
  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> Enum.sort()
    # greedy distribute works for nearly all cases excect 5/3 groupings
    |> Enum.reduce([], fn item, groups ->
      distribute(item, groups)
    end)
    # convert to a map of frequencies, we're looking for %{5 => 1, 3 => 1}
    # we don't need to know "what" is in the basket, so we can safely convert
    # to a data structure that's easier to work with such
    # # as "three groups twice"
    # %{3 => 2}
    # or more importantly, 5 /3  groups
    |> Enum.frequencies_by(&length/1)
    # fix the 5/3 groups ... %{5 => 1, 3 => 1}
    |> rebalance()
    #  finally we can calculate the price and that's easier now becasue
    #  reduce on a map gives us key, values which translates nicely into
    #  qty and how many groups of that quantity we have.
    |> Enum.reduce(0, fn {qty, count}, acc -> acc + count * qty * price(qty) end)

    # I'm going to work up to the hard ones from now on...
  end

  defp rebalance(counts) do
    # how many pairs of 5 / 3 groups can we take?
    pairs = min(Map.get(counts, 5, 0), Map.get(counts, 3, 0))

    counts
    # subtract from five and three groups, and insert the more
    # optimal four groups.
    |> Map.update(5, 0, &(&1 - pairs))
    |> Map.update(3, 0, &(&1 - pairs))
    |> Map.update(4, pairs * 2, &(&1 + pairs * 2))
  end

  # this is the first call in greedy distribution
  defp distribute(item, []) do
    [[item]]
  end

  # and successive calls go through this one
  defp distribute(item, [group | rest]) do
    if item in group do
      # this group already has item, try the next one
      # the key here is how the recurse is done
      [group | distribute(item, rest)]
    else
      # place item here and leave the rest unchanged
      [[item | group] | rest]
    end
  end

  # price with discount applied
  defp price(1), do: @price
  defp price(2), do: @price - 40
  defp price(3), do: @price - 80
  defp price(4), do: @price - 160
  defp price(5), do: @price - 200
end
