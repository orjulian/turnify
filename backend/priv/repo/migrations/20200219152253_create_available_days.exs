defmodule Turnify.Repo.Migrations.CreateAvailableDays do
  use Ecto.Migration

  def change do
    create table(:available_days) do
      add :day, :string
      add :hours, {:array, :string}
      add :calendar_id, references("calendars")

      timestamps()
    end

    create unique_index(:available_days, [:day, :calendar_id], name: :calendar_day)
  end
end
