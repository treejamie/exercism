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
    case {seconds / @seconds_in_year, planet} do
      {years, :earth} -> {:ok, years}
      {years, :mercury} -> {:ok, years * (1 / 0.2408467)}
      {years, :venus} -> {:ok, years * (1 / 0.61519726)}
      {years, :mars} -> {:ok, years / 1.8808158}
      {years, :jupiter} -> {:ok, years / 11.86261}
      {years, :saturn} -> {:ok, years / 29.447498}
      {years, :uranus} -> {:ok, years / 84.016846}
      {years, :neptune} -> {:ok, years / 164.79132}
      {_years, _planet} -> {:error, "not a planet"}
    end
  end
end
