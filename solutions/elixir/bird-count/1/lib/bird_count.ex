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

  def total(list_of_birds, count \\ 0)
  def total([], count), do: count
  def total([head | tail], count), do: total(tail, head + count)


  def busy_days(list_of_bird_counts, count \\ 0)
  def busy_days([], count), do: count
  def busy_days([head | tail], count) when head > 4, do: busy_days(tail, count + 1)
  def busy_days([_head | tail], count), do: busy_days(tail, count)
end
