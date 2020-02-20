defmodule Turnify.CalendarsTest do
  use Turnify.DataCase

  alias Turnify.Calendars

  describe "calendars" do
    alias Turnify.Calendars.Calendar

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def calendar_fixture(attrs \\ %{}) do
      {:ok, calendar} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendars.create_calendar()

      calendar
    end

    test "list_calendars/0 returns all calendars" do
      calendar = calendar_fixture()
      assert Calendars.list_calendars() == [calendar]
    end

    test "get_calendar!/1 returns the calendar with given id" do
      calendar = calendar_fixture()
      assert Calendars.get_calendar!(calendar.id) == calendar
    end

    test "create_calendar/1 with valid data creates a calendar" do
      assert {:ok, %Calendar{} = calendar} = Calendars.create_calendar(@valid_attrs)
    end

    test "create_calendar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendars.create_calendar(@invalid_attrs)
    end

    test "update_calendar/2 with valid data updates the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{} = calendar} = Calendars.update_calendar(calendar, @update_attrs)
    end

    test "update_calendar/2 with invalid data returns error changeset" do
      calendar = calendar_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendars.update_calendar(calendar, @invalid_attrs)
      assert calendar == Calendars.get_calendar!(calendar.id)
    end

    test "delete_calendar/1 deletes the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{}} = Calendars.delete_calendar(calendar)
      assert_raise Ecto.NoResultsError, fn -> Calendars.get_calendar!(calendar.id) end
    end

    test "change_calendar/1 returns a calendar changeset" do
      calendar = calendar_fixture()
      assert %Ecto.Changeset{} = Calendars.change_calendar(calendar)
    end
  end

  describe "available_days" do
    alias Turnify.Calendars.AvailableDay

    @valid_attrs %{day: "some day"}
    @update_attrs %{day: "some updated day"}
    @invalid_attrs %{day: nil}

    def available_day_fixture(attrs \\ %{}) do
      {:ok, available_day} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendars.create_available_day()

      available_day
    end

    test "list_available_days/0 returns all available_days" do
      available_day = available_day_fixture()
      assert Calendars.list_available_days() == [available_day]
    end

    test "get_available_day!/1 returns the available_day with given id" do
      available_day = available_day_fixture()
      assert Calendars.get_available_day!(available_day.id) == available_day
    end

    test "create_available_day/1 with valid data creates a available_day" do
      assert {:ok, %AvailableDay{} = available_day} = Calendars.create_available_day(@valid_attrs)
      assert available_day.day == "some day"
    end

    test "create_available_day/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendars.create_available_day(@invalid_attrs)
    end

    test "update_available_day/2 with valid data updates the available_day" do
      available_day = available_day_fixture()
      assert {:ok, %AvailableDay{} = available_day} = Calendars.update_available_day(available_day, @update_attrs)
      assert available_day.day == "some updated day"
    end

    test "update_available_day/2 with invalid data returns error changeset" do
      available_day = available_day_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendars.update_available_day(available_day, @invalid_attrs)
      assert available_day == Calendars.get_available_day!(available_day.id)
    end

    test "delete_available_day/1 deletes the available_day" do
      available_day = available_day_fixture()
      assert {:ok, %AvailableDay{}} = Calendars.delete_available_day(available_day)
      assert_raise Ecto.NoResultsError, fn -> Calendars.get_available_day!(available_day.id) end
    end

    test "change_available_day/1 returns a available_day changeset" do
      available_day = available_day_fixture()
      assert %Ecto.Changeset{} = Calendars.change_available_day(available_day)
    end
  end
end
