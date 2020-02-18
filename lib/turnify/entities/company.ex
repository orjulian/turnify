defmodule Turnify.Entities.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Turnify.Accounts.User

  schema "companies" do
    field :name, :string
    field :token, :string
    
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> unique_constraint(:token)
    |> generate_token
  end

  defp generate_token(changeset) do
    name = get_change(changeset, :name)
    changeset
    |> change(%{token: :base64.encode(:crypto.strong_rand_bytes(24))})
  end
end
