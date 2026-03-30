defmodule RemoteControlCar do

  @enforce_keys :nickname

  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0,
  ]


  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      level -> "Battery at #{level}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) when remote_car.battery_percentage > 0 do
    remote_car
    |> Map.update!(:distance_driven_in_meters, fn distance -> distance + 20 end)
    |> Map.update!(:battery_percentage, fn level -> level - 1 end)
  end
  def drive(%RemoteControlCar{} = remote_car), do: remote_car
end
