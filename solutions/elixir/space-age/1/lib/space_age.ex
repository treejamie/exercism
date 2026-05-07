defmodule SpaceAge do
  @seconds_in_year 31_557_600
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    seconds
    |> seconds_to_years()
    |> years_to_planet(planet)
  end

  defp seconds_to_years(seconds), do: seconds / @seconds_in_year

  defp years_to_planet(years, :earth), do: {:ok, years}
  defp years_to_planet(years, :mercury), do: {:ok, years * (1 / 0.2408467)}
  defp years_to_planet(years, :venus), do: {:ok, years * (1 / 0.61519726)}
  defp years_to_planet(years, :mars), do: {:ok, years / 1.8808158}
  defp years_to_planet(years, :jupiter), do: {:ok, years / 11.86261}
  defp years_to_planet(years, :saturn), do: {:ok, years / 29.447498}
  defp years_to_planet(years, :uranus), do: {:ok, years / 84.016846}
  defp years_to_planet(years, :neptune), do: {:ok, years / 164.79132}
  defp years_to_planet(_years, _planet), do: {:error, "not a planet"}
end
