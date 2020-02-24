defmodule Turnify.Calendars do
  @moduledoc """
  The Calendars context.
  """

  import Ecto.Query, warn: false
  alias Turnify.Repo

  alias Turnify.Calendars.Calendar
  alias Turnify.Calendars.AvailableDay

  @doc """
  Returns the list of calendars.

  ## Examples

      iex> list_calendars()
      [%Calendar{}, ...]

  """
  def list_calendars do
    Repo.all(Calendar)
  end

  @doc """
  Gets a single calendar.

  Raises `Ecto.NoResultsError` if the Calendar does not exist.

  ## Examples

      iex> get_calendar!(123)
      %Calendar{}

      iex> get_calendar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_calendar!(id), do: Repo.get!(Calendar, id)

  @doc """
  Creates a calendar.

  ## Examples

      iex> create_calendar(%{field: value})
      {:ok, %Calendar{}}

      iex> create_calendar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_calendar(attrs \\ %{}) do
    %Calendar{}
    |> Calendar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a calendar.

  ## Examples

      iex> update_calendar(calendar, %{field: new_value})
      {:ok, %Calendar{}}

      iex> update_calendar(calendar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_calendar(%Calendar{} = calendar, attrs) do
    calendar
    |> Calendar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a calendar.

  ## Examples

      iex> delete_calendar(calendar)
      {:ok, %Calendar{}}

      iex> delete_calendar(calendar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_calendar(%Calendar{} = calendar) do
    Repo.delete(calendar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking calendar changes.

  ## Examples

      iex> change_calendar(calendar)
      %Ecto.Changeset{source: %Calendar{}}

  """
  def change_calendar(%Calendar{} = calendar) do
    Calendar.changeset(calendar, %{})
  end

  @doc """
  Returns a %Struct{}, the one belonging to the record that's being created.

  The assoc param refers to the association being created, 
  and the set param refers to a struct containing its attributes
  ## Examples

  iex> Turnify.Calendars.put_calendar_assoc(calendar, :available_days, %Turnify.Calendars.AvailableDay{day: "Thursday", hours: ["16:30", "16:45"]})
  %Turnify.Calendars.AvailableDay{}
  """
  def put_calendar_assoc(calendar, assoc, set) do
    calendar
    |> Repo.preload(assoc)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(assoc, set)
    |> Repo.update()
  end

  @doc """
  Returns the list of available_days.

  ## Examples

      iex> list_available_days()
      [%AvailableDay{}, ...]

  """
  def list_available_days do
    Repo.all(AvailableDay)
  end

  @doc """
  Gets a single available_day.

  Raises `Ecto.NoResultsError` if the Available day does not exist.

  ## Examples

      iex> get_available_day!(123)
      %AvailableDay{}

      iex> get_available_day!(456)
      ** (Ecto.NoResultsError)

  """
  def get_available_day!(id), do: Repo.get!(AvailableDay, id)

  @doc """
  Creates a available_day.

  ## Examples

      iex> create_available_day(%{field: value})
      {:ok, %AvailableDay{}}

      iex> create_available_day(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_available_day(attrs \\ %{}) do
    %AvailableDay{}
    |> AvailableDay.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a available_day.

  ## Examples

      iex> update_available_day(available_day, %{field: new_value})
      {:ok, %AvailableDay{}}

      iex> update_available_day(available_day, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_available_day(%AvailableDay{} = available_day, attrs) do
    available_day
    |> AvailableDay.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a available_day.

  ## Examples

      iex> delete_available_day(available_day)
      {:ok, %AvailableDay{}}

      iex> delete_available_day(available_day)
      {:error, %Ecto.Changeset{}}

  """
  def delete_available_day(%AvailableDay{} = available_day) do
    Repo.delete(available_day)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking available_day changes.

  ## Examples

      iex> change_available_day(available_day)
      %Ecto.Changeset{source: %AvailableDay{}}

  """
  def change_available_day(%AvailableDay{} = available_day) do
    AvailableDay.changeset(available_day, %{})
  end
end
