defmodule TurnifyWeb.Resolvers.Calendar do
  require IEx

  alias Turnify.{Repo, Calendars}

  def create_available_day(_, args, %{context: %{current_calendar: current_calendar}}) do
    available_day = Calendars.create_available_day(args)

    Calendars.put_calendar_assoc(current_calendar, :available_days, [available_day])

    available_day
  end

  def create_available_day(_, args, _) do
    {:error, "Unauthorized"}
  end

  def create_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end
end
