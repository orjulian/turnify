defmodule Turnify.Repo.Migrations.UsersAddRolesField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :roles, {:array, :string}, default: ["professional"]
    end
  end
end
