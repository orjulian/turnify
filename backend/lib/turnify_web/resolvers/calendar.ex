defmodule TurnifyWeb.Resolvers.Calendar do
  require IEx

  alias Turnify.Calendars

  def create_available_day(_, args, %{context: %{current_calendar: current_calendar}}) do
    hours =
      Calendars.HourCalculations.add_minutes(
        args[:hour_from],
        args[:minutes_span],
        args[:hour_to]
      )

    attrs = %{day: args[:day], hours: hours}
    # Need to handle error properly
    # Something like block below
    available_day = Calendars.AvailableDay.changeset(%Calendars.AvailableDay{}, attrs)

    case Calendars.put_calendar_assoc(current_calendar, :available_days, [
           available_day | current_calendar.available_days
         ]) do
      {:ok, _} -> {:ok, attrs}
      # Here will be better to fetch errors from changeset
      {:error, _changeset} -> {:error, "AvailableDay is invalid"}
    end
  end

  def create_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end
end
