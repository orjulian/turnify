defmodule TurnifyWeb.Resolvers.Company do
  require IEx
  alias Turnify.{Repo, Entities.Company}

  def create_company(_root, _args, %{ context: %{current_user: current_user, current_company: current_company} }) do
    { :error, "Current User already has a Company associated" }
  end

  # Create company only if current_company is nil
  def create_company(_root, args, %{ context: %{current_user: current_user} }) do
    company = Company.changeset(%Company{}, args)
    company = Repo.insert!(company)

    current_user
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:company, company)
    |> Repo.update
    
    { :ok, company }
  end

  def create_company(_root, _args, _context) do
    { :error, "Unauthorized" }
  end
end
