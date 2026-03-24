defmodule Rules do
  def eat_ghost?(power_pellet_active?, touching_ghost?) do
    Enum.all?([power_pellet_active?, touching_ghost?])
  end

  def score?(touching_power_pellet?, touching_dot?) do
    Enum.any?([touching_power_pellet?, touching_dot?])
  end

  def lose?(power_pellet_active?, touching_ghost?) do
    case {power_pellet_active?, touching_ghost?} do
      {false, true} -> true
      _ -> false
    end
  end

  def win?(has_eaten_all_dots?, power_pellet_active?, touching_ghost?) do
    Enum.all?([has_eaten_all_dots?, not lose?(power_pellet_active?, touching_ghost?)])
  end
end
