defmodule Turnify.Calendars.HourCalculations do
  def add_minutes(hour, minutes, scoped_hour, hours \\ [])

  def add_minutes(hour, minutes, scoped_hour, hours) do
    hours = [hour | hours]

    case add_minutes(hour, minutes) do
      current_hour when current_hour <= scoped_hour ->
        add_minutes(current_hour, minutes, scoped_hour, hours)

      current_hour when current_hour > scoped_hour ->
        hours
    end
  end

  def add_minutes(hour, minutes) do
    [hr, mn] = String.split(hour, ":")
    {mn, _} = Integer.parse(mn)
    new_minutes = mn + minutes

    case new_minutes do
      x when x >= 60 ->
        remanent =
          (new_minutes - 60)
          |> Integer.to_string()
          |> String.pad_leading(2, "0")

        {hr, _} = Integer.parse(hr)
        new_hour = hr + 1
        "#{new_hour}:#{remanent}"

      _ ->
        "#{hr}:#{new_minutes}"
    end
  end
end
