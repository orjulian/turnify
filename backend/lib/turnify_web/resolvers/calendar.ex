defmodule TurnifyWeb.Resolvers.Calendar do
  require IEx

  alias Turnify.{Repo, Calendars}

  # CREATE

  def create_available_day(_info, args, %{
        context: %{current_user: current_user, current_calendar: current_calendar}
      }) do
    current_calendar = resolve_professional_current_calendar(current_user, current_calendar, args)

    create(args, current_calendar)
  end

  def create_available_day(_info, args, %{context: %{current_user: current_user}}) do
    if args[:scoped_calendar_id] do
      current_calendar = resolve_admin_current_calendar(current_user, args)

      delete(args, current_calendar)
    else
      {:error, "Scoped calendar id is needed"}
    end
  end

  def create_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end

  # DELETE

  def delete_available_day(_info, args, %{
        context: %{current_user: current_user, current_calendar: current_calendar}
      }) do
    current_calendar = resolve_professional_current_calendar(current_user, current_calendar, args)

    delete(args, current_calendar)
  end

  def delete_available_day(_, args, %{context: %{current_user: current_user}}) do
    if args[:scoped_calendar_id] do
      current_calendar = resolve_admin_current_calendar(current_user, args)

      delete(args, current_calendar)
    else
      {:error, "Scoped calendar id is needed"}
    end
  end

  def delete_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end

  # UPDATE

  def update_available_day(_info, args, %{
        context: %{current_user: current_user, current_calendar: current_calendar}
      }) do
    current_calendar = resolve_professional_current_calendar(current_user, current_calendar, args)

    update(args, current_calendar)
  end

  def update_available_day(_, args, %{context: %{current_user: current_user}}) do
    if args[:scoped_calendar_id] do
      current_calendar = resolve_admin_current_calendar(current_user, args)

      update(args, current_calendar)
    else
      {:error, "Scoped calendar id is needed"}
    end
  end

  def update_available_day(_, _, _) do
    {:error, "Unauthorized"}
  end

  # PRIVATE METHODS

  defp create(args, current_calendar) do
    hours = Calendars.HourCalculations.add_minutes(args[:time_range])

    attrs = %{day: args[:day], hours: hours}
    # Need to handle error properly
    # Something like block below
    available_day = Calendars.AvailableDay.changeset(%Calendars.AvailableDay{}, attrs)

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

  defp delete(args, current_calendar) do
    # Create query for Repo search
    available_day = resolve_available_day(current_calendar, args)

    case Repo.delete(available_day) do
      {:ok, struct} -> {:ok, struct}
      {:error, _changeset} -> {:error, "Cannot found available day"}
    end
  end

  defp update(args, current_calendar) do
    available_day = resolve_available_day(current_calendar, args)

    hours = Calendars.HourCalculations.add_minutes(args[:time_range])
    attrs = %{day: args[:day], hours: hours}

    available_day = Ecto.Changeset.change(available_day, attrs)

    case Repo.update(available_day) do
      {:ok, struct} -> {:ok, struct}
      {:error, _changeset} -> {:error, "Cannot found available day"}
    end
  end

  # NOTE TO DISCUSS
  # Here would be better a case
  # Where we validate the presence of scoped_calendar_id and admin role
  # When both are met, return calendar
  # When scoped_calendar_id is present but admin role isn't, raise an error
  # When scoped_calendar_id isn't present, use current_calendar
  defp resolve_professional_current_calendar(current_user, current_calendar, args) do
    if args[:scoped_calendar_id] && Enum.member?(current_user.roles, "admin") do
      Calendars.get_calendar!(args[:scoped_calendar_id])
      |> Repo.preload(:available_days)
    else
      current_calendar
    end
  end

  # Need current_user role validation
  # Only an admin should be able to use it
  defp resolve_admin_current_calendar(_current_user, args) do
    Calendars.get_calendar!(args[:scoped_calendar_id])
    |> Repo.preload(:available_days)
  end

  defp resolve_available_day(current_calendar, args) do
    query = Ecto.assoc(current_calendar, :available_days)
    Repo.get_by(query, day: args[:day])
  end
end
