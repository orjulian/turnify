defmodule Turnify.Repo.Migrations.UsersAddCompanyReference do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :company_id, references("companies")
    end
  end
end
