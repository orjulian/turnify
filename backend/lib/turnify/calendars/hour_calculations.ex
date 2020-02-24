defmodule Turnify.Calendars.HourCalculations do
  require IEx

  @desc """
  When we call add_minutes/3, we assign a default array of hours where to store the future generated hour operations.

  The arguments' format are:
  hour = String("hh:mm")
  minutes = Int
  scoped_hour = String("hh:mm")

  scoped_hour must be greater than hour. Otherwise, it'll return an empty array.

  Both scoped_hour and hour are inclusive and will be added to the hours array.

  Example usage:
    iex(1)> Turnify.Calendars.HourCalculations.add_minutes("16:30", 15, "18:00")
    ["18:00", "17:45", "17:30", "17:15", "17:00", "16:45", "16:30"]
  """
  def add_minutes(hour, minutes, scoped_hour, hours \\ [])

  def add_minutes(hour, minutes, scoped_hour, hours) do
    # Add the first hour by default
    hours = [hour | hours]

    # Call add_minutes/2 to handle time addition
    case add_minutes(hour, minutes) do
      # If hour is smaller than scoped_hour, repeat
      current_hour when current_hour <= scoped_hour ->
        add_minutes(current_hour, minutes, scoped_hour, hours)

      # Otherwise, return array of hours
      _ ->
        hours
    end
  end

  def add_minutes(hour, minutes) do
    # Split the hour based on time separator
    # It can be parameterized in a future.
    # hour format: hh:mm. 
    # E.g.: 16:45
    [hr, mn] = String.split(hour, ":")

    # Transform minutes to Integer and perform time addition, 
    # therefore validate if minutes are bigger than 60 (an hour)
    case String.to_integer(mn) + minutes do
      # Case positive
      new_minutes when new_minutes >= 60 ->
        # calculate the minutes' remanent
        remanent =
          (new_minutes - 60)
          |> Integer.to_string()
          |> String.pad_leading(2, "0")

        new_hour = String.to_integer(hr) + 1
        "#{new_hour}:#{remanent}"

      # Else return minutes sum
      new_minutes ->
        "#{hr}:#{new_minutes}"
    end
  end

  @desc """
  This time we loop through a list of multiple time ranges.
  For example: 
  [
    {hour_from: "11:00", hour_to: "11:30", minutes_span: 10}, 
    {hour_from: "16:00", hour_to: "16:30", minutes_span: 15}
  ]

  And it will return:
  ["16:30",
  "16:15",
  "16:00",
  "11:30",
  "11:20",
  "11:10",
  "11:00"]

  This allows us to threat multiple time ranges differently, with its own minutes span
  and assign them all in a single transaction later.
  """
  def add_minutes(time_range) do
    hours =
      for time <- time_range do
        add_minutes(time[:hour_from], time[:minutes_span], time[:hour_to])
      end

    List.flatten(hours)
  end
end
