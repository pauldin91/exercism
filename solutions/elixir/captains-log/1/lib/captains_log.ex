defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    # Please implement the random_planet_class/0 function

    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    # Please implement the random_ship_registry_number/0 function
    "NCC-" <> (Enum.random(1000..9999)|> Integer.to_string)
  end

  def random_stardate() do
    # Please implement the random_stardate/0 function
    min = 41000.0
    max = 42000.0
    min + (:rand.uniform() * (max - min))
  end

  def format_stardate(stardate) when is_integer(stardate), do: raise ArgumentError
  def format_stardate(stardate) when is_float(stardate) do
    # Please implement the format_stardate/1 function
    stardate |> Float.round(1) |> Float.to_string()
  end
end
