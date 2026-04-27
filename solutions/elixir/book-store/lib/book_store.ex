defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @base_price 800

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> to_quantities()
    |> calculate_discount()
  end

  @doc """
  Calculate the cost of every possible combination in the basket where
  k is the current size of the group. For each permutation of K
   - get price from memosied basket map using quantities as cache key
      - miss: calculate the price, add it to map
      - hit: move on
   - take the minimum of the recursive calls.
   - recurse
  """
  def calculate_discount([]), do: 0

  def calculate_discount(quantities) do
    # note to future Jamie - use Enum.reduce and pass memoised state
    # around like that.
  end

  def cost_of_group(k) do
    IO.inspect(k)
    800
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
  """
  def to_quantities(quantities) do
    quantities
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
  end
end
