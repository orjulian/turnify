defmodule Turnify.Calendars.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  alias Turnify.{Accounts.User}

  schema "calendars" do
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [])
    |> validate_required([])
  end
end
