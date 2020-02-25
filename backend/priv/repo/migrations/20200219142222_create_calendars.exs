defmodule Turnify.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :user_id, references("users")

      timestamps()
    end
  end
end
