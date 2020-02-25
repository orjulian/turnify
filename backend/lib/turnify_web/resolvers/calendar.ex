defmodule TurnifyWeb.Resolvers.Calendar do
  require IEx

  alias Turnify.{Repo, Calendars}

  def create_available_day(_info, args, %{
        context: %{current_user: current_user, current_calendar: current_calendar}
      }) do
    current_calendar =
      if args[:scoped_calendar_id] && Enum.member?(current_user.roles, "admin") do
        Calendars.get_calendar!(args[:scoped_calendar_id])
        |> Repo.preload(:available_days)
      else
        current_calendar
      end

    create(args, current_calendar)
  end

  def create_available_day(_info, args, %{context: %{current_user: current_user}}) do
    if args[:scoped_calendar_id] do
      current_calendar =
        Calendars.get_calendar!(args[:scoped_calendar_id])
        |> Repo.preload(:available_days)

      create(args, current_calendar)
    else
      {:error, "Scoped calendar id is needed"}
    end
  end

  def create_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end

  defp create(args, current_calendar) do
    hours = Calendars.HourCalculations.add_minutes(args[:time_range])

    attrs = %{day: args[:day], hours: hours}
    # Need to handle error properly
    # Something like block below
    available_day = Calendars.AvailableDay.changeset(%Calendars.AvailableDay{}, attrs)
    IEx.pry()

    case Calendars.put_calendar_assoc(current_calendar, :available_days, [
           available_day | current_calendar.available_days
         ]) do
      {:ok, _} ->
        {:ok, attrs}

      # Here will be better to fetch errors from changeset
      {:error, changeset} ->
        {:error, "AvailableDay is invalid"}
    end
  end
end
