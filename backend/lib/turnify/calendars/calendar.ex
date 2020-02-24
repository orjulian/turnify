defmodule Turnify.Calendars.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  alias Turnify.{Accounts.User, Calendars.AvailableDay}

  schema "calendars" do
    belongs_to :user, User
    has_many :available_days, AvailableDay, on_replace: :mark_as_invalid

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [])
    |> validate_required([])
  end
end
