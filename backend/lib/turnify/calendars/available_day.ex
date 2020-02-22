defmodule Turnify.Calendars.AvailableDay do
  require IEx
  use Ecto.Schema
  import Ecto.Changeset

  alias Turnify.Calendars.Calendar

  schema "available_days" do
    field :day, :string
    field :hours, {:array, :string}

    belongs_to :calendar, Calendar

    timestamps()
  end

  @doc false
  def changeset(available_day, attrs) do
    available_day
    |> cast(attrs, [:day, :hours])
    |> validate_required([:day, :hours])
    |> unique_constraint(:day, name: :calendar_day)
    |> validate_hours_format
    |> validate_hours_uniqueness
  end

  defp validate_hours_format(changeset) do
    band =
      Enum.all?(get_field(changeset, :hours), fn hour ->
        String.match?(hour, ~r/^[0-23]{2}:[0-59]{2}$/)
      end)

    cond do
      band -> changeset
      true -> %{changeset | errors: ["Invalid hour format"] ++ changeset.errors, valid?: false}
    end
  end

  defp validate_hours_uniqueness(changeset) do
    case get_field(changeset, :hours) do
      nil ->
        changeset

      hours ->
        new_hours = Enum.uniq(hours)
        put_change(changeset, :hours, new_hours)
    end
  end
end
