defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ []) do
    max_price = Keyword.get(opts, :maximum_price, 100)

    for top <- tops,
        bottom <- bottoms,
        top[:base_color] != bottom[:base_color] and
          affordable?(top[:price], bottom[:price], max_price) do
      {top, bottom}
    end
  end

  defp affordable?(top_price, bottom_price, max_price), do: top_price + bottom_price <= max_price
end
