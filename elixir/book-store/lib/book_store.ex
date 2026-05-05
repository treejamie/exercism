defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> to_quantities()
    |> IO.inspect(label: "👋👋")
    |> calculate_price()
  end

  @doc """
  We only need to know the distribution of quantities for each book type.

  Also, sort descending.

  One one
  [1,1,1] -> [1]

  Three fives, two fours and one one
  [1,4,4,5,5,5] -> [3,2,1]

  Quantities of each type matches type - mental mindgames,
  like seeing "white" written in red ink.
  [1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5] -> [1,2,3,4,5]

  Remember that you're after this function you don't need the 'types'
  you're just interested in the quantity distribution.

  So three fives, two fours and one one [1,4,4,5,5,5] translated into
  [3,2,1] contains all the information you need. There's three of one kind,
  two of another, and one of another.



  """
  def to_quantities(quantities) do
    quantities
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
  end

  def calculate_price(quantities) do
    Enum.map(quantities, fn qty ->
      discount(qty) * 800 * qty
    end)
    |> IO.inspect(label: "🍓🍓")
    |> Enum.min()
  end

  def discount(1), do: 1.00
  def discount(2), do: 0.95
  def discount(3), do: 0.90
  def discount(4), do: 0.80
  def discount(5), do: 0.75
end
