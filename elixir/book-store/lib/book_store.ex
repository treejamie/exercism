defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    # we need to know how many "groups" the basket needs to be
    # in, the hard rule here is that it would un unoptimum for
    # a book type to be in a basket group more than once. So
    # we can use Enum.frequency to drive that logic and take the
    # max value from that list.
    basket
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.max()

    # |> make_groups()
    # |> Enum.flat_map(fn group ->
    #   transformed_group =
    #     Enum.map(basket, fn item ->
    #       # IO.inspect({group, item})
    #       if item not in group do
    #         group ++ [item]
    #       end
    #     end)
    # end)
    # |> IO.inspect(label: "groups")

    # now we have the groups we want to iterate over each item
    # in the basket, placing each item into one of the groups so
    # that everything in the group is unique.
    #
    # Enum.map(groups

    # Enum.map(basket, fn item ->
    #   groups
    #   |> Enum.map(fn group ->
    #   end)
    # end)
    # |> IO.inspect(label: "result")

    # |> do_distribute(basket)
    # |> IO.inspect()
  end

  defp do_distribute(groups, []), do: groups

  defp do_distribute(groups, [item | rest]) do
    IO.inspect(item, label: "👋👋")

    # this is a good case for reduce_while as once
    # an item is placed, there is no point in continuing

    groups =
      groups
      |> Enum.reduce(fn group, acc ->
        IO.inspect(group)

        if item in group do
          acc
        else
          [acc | item]
        end
        |> IO.inspect(label: "reduce")
      end)

    do_distribute(groups, rest)
  end

  # the basket needs groups to organise everything into.
  # ie: [1, 1, 2, 2, 3, 3, 4, 5] -> [[1,2,3,4],[1,2,3,5]]
  # the groups are decided by the frequencies of things
  # in the basket
  defp make_groups(quantities) do
    max_groups =
      quantities
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.max()

    List.duplicate([], max_groups)
  end

  def calculate_price(quantities) do
    Enum.map(quantities, fn qty ->
      discount(qty) * 800 * qty
    end)
    |> IO.inspect(label: "🍓🍓")
    |> Enum.min()
  end

  defp discount(1), do: 1.00
  defp discount(2), do: 0.95
  defp discount(3), do: 0.90
  defp discount(4), do: 0.80
  defp discount(5), do: 0.75
end
