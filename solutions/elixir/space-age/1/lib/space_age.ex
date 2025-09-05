defmodule SpaceAge do
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
    cond do
      planet ==:mercury -> {:ok,years_from_seconds(seconds) / 0.2408467}
      planet ==:venus -> {:ok,years_from_seconds(seconds) / 0.61519726}
      planet == :earth -> {:ok,years_from_seconds(seconds) }
      planet == :mars -> {:ok,years_from_seconds(seconds) / 1.8808158}
      planet == :jupiter -> {:ok,years_from_seconds(seconds) / 11.862615}
      planet == :saturn -> {:ok,years_from_seconds(seconds) / 29.447498}
      planet == :uranus -> {:ok,years_from_seconds(seconds) / 84.016846}
      planet == :neptune -> {:ok,years_from_seconds(seconds) / 164.79132}
      true -> {:error,"not a planet"} 
    end
  end
  
  def years_from_seconds(seconds) do
    (((seconds)/3600)/24)/365.25
    end
end
