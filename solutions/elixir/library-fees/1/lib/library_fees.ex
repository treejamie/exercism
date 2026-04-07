defmodule LibraryFees do
  def datetime_from_string(string) do
    string
    |> NaiveDateTime.from_iso8601!()
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> then(fn time ->
      time.hour <= 11 and time.minute <= 59 and time.second <= 59
    end)
  end

  def return_date(checkout_datetime) do
    days =
      if before_noon?(checkout_datetime) do
        28
      else
        29
      end

    NaiveDateTime.add(checkout_datetime, days, :day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)

    if diff < 0 do
      0
    else
      diff
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> then(fn day -> day == 1 end)
  end

  def calculate_late_fee(checkout, return, rate) do
    actual_return_date = datetime_from_string(return)

    return_due =
      checkout
      |> datetime_from_string
      |> return_date()

    actual_days_late =
      return_due
      |> days_late(actual_return_date)

    fee =
      if monday?(actual_return_date) do
        actual_days_late * rate * 0.5
      else
        actual_days_late * rate
      end

    floor(fee)
  end
end
