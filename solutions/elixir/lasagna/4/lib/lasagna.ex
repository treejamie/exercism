defmodule Lasagna do
  @moduledoc """
  A module to assist in cooking lasange.
  """
  @doc """
  always forty minutes to cook lasangne; always
  """
  def expected_minutes_in_oven, do: 40


  def remaining_minutes_in_oven(minutes_in_oven) do
    expected_minutes_in_oven() - minutes_in_oven
  end

  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(layers, minutes_in_oven) do
    preparation_time_in_minutes(layers) + minutes_in_oven
  end

  def alarm do
    "Ding!"
  end
end
