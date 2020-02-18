defmodule Turnify.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :token, :string

      timestamps()
    end

    create unique_index(:companies, [:name])
    create unique_index(:companies, [:token])
  end
end
