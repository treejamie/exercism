defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort(fn x, y -> x[:price] <= y[:price] end)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&(&1[:price] == nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn val ->
      %{val | name: String.replace(val[:name], old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    updated =
      item[:quantity_by_size]
      |> Enum.reduce(item[:quantity_by_size], fn {key, val}, acc ->
        Map.put(acc, key, val + count)
      end)

    %{item | quantity_by_size: updated}
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_k, val}, acc -> acc + val end)
  end
end
