defmodule Turnify.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  require IEx

  alias Turnify.Accounts.{User, Encryption}
  alias Turnify.Entities.Company
  alias Turnify.Repo

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string
    field :token, :string
    field :roles, {:array, :string}, default: ["professional"]

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, [:roles]])
    |> validate_inclusion(:roles, ~w(professional admin patient))
    |> validate_required([:username, :email])
    |> validate_length(:password, min: 6)
    |> validate_length(:username, min: 3)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  def store_token(%User{} = user, token) do
    user
    |> change(%{ token: token })
    |> Repo.update()
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      add_error(changeset, :encrypted_password, "No password")
    end
  end
end
