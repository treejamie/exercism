defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    index = rand(0, length(@planetary_classes))
    Enum.at(@planetary_classes, index)
  end

  def random_ship_registry_number(), do: "NCC-#{rand(1000, 9999)}"

  def random_stardate(), do: 41_000 + :rand.uniform() * 1000

  def format_stardate(stardate), do: :erlang.float_to_binary(stardate, decimals: 1)

  defp rand(lower, upper) do
    :rand.uniform(upper - lower)
    |> Kernel.+(lower - 1)
  end
end
