defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]),  do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head |tail]) do
    case head do
      0 -> true
      _ -> has_day_without_birds?(tail)
    end
  end

  def total(list), do: total(list, 0)
  defp total([], count), do: count
  defp total([head | tail], count), do: total(tail, head + count)

  def busy_days(list), do: busy_days(list, 0)
  defp busy_days([], count), do: count
  defp busy_days([head | tail], count) when head > 4, do: busy_days(tail, count + 1)
  defp busy_days([_head | tail], count), do: busy_days(tail, count)
end
