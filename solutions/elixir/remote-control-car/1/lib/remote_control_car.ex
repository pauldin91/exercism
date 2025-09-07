defmodule RemoteControlCar do
  # Please implement the struct with the specified fields
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    # Please implement the new/0 function
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    # Please implement the new/1 function
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar),
    do: to_string(remote_car.distance_driven_in_meters) <> " meters"

  def display_battery(remote_car)
      when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage == 0,
      do: "Battery empty"

  def display_battery(remote_car)
      when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage > 0,
      do: "Battery at #{remote_car.battery_percentage}%"

  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage == 0, do: remote_car


  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage > 0 do
    # Please implement the drive/1 function
    %RemoteControlCar{
      nickname: remote_car.nickname,
      battery_percentage: remote_car.battery_percentage - 1,
      distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end
end
