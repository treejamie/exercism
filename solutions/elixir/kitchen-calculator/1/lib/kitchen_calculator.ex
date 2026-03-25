defmodule KitchenCalculator do
  @moduledoc """
  Converts units from silly imperial to the sensible 
  base 10 kind where everything makes sense.
  """

  @cup 240
  @fluid_ounce 30
  @teaspoon 5
  @tablespoon 15

  @doc """
  Shortcut to getting a quantity from a measurement tuple.

  ## Example

    iex> KitchenCalculator.get_volume({:cup, 1})
    1
  
  """
  def get_volume({_measurement, qty}), do: qty

  @doc """
  Converts imperial to milliliter.

  ## Example
    iex> KitchenCalculator.to_milliliter({:fluid_ounce, 100})
    {:milliliter, 3000}
  """
  def to_milliliter({:milliliter, qty}), do: {:milliliter, qty}
  def to_milliliter({:cup, qty}), do: {:milliliter, qty * @cup}
  def to_milliliter({:fluid_ounce, qty}), do: {:milliliter, qty * @fluid_ounce}
  def to_milliliter({:teaspoon, qty}), do: {:milliliter, qty * @teaspoon}
  def to_milliliter({:tablespoon, qty}), do: {:milliliter, qty * @tablespoon}

  @doc """
  Converts milliliter to imperial.

  ## Example
    iex> KitchenCalculator.from_milliliter({:milliliter, 840}
    {:cup, 3.5}
  """

  def from_milliliter({:milliliter, qty}, :milliliter = measure), do: {measure, qty}
  def from_milliliter({:milliliter, qty}, :cup = measure), do: {measure, qty / @cup }
  def from_milliliter({:milliliter, qty}, :fluid_ounce = measure), do: {measure, qty / @fluid_ounce }
  def from_milliliter({:milliliter, qty}, :teaspoon = measure), do: {measure, qty / @teaspoon }
  def from_milliliter({:milliliter, qty}, :tablespoon = measure), do: {measure, qty / @tablespoon }

  @doc """
  Converts any unit from one unit to another.

  ## Example
    iex> KitchenCalculator.convert({:teaspoon, 15}, :tablespoon) 
    {:tablespoon, 5}
  
  """
  def convert(measurement_tuple, target) do
    measurement_tuple
      |> to_milliliter()
      |> from_milliliter(target)
  end
end
