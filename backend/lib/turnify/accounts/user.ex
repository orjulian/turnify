defmodule Turnify.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  require IEx

  alias Turnify.Accounts.{User, Encryption}
  alias Turnify.{Repo, Entities.Company, Calendars.Calendar}

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :token, :string
    field :roles, {:array, :string}, default: ["professional"]

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :company,  Company
    has_one    :calendar, Calendar

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:password, :email])
    |> validate_required([:email])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  def patient_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> change(%{roles: ["patient"]})
  end

  def professional_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> change(%{roles: ["professional"]})
  end

  def admin_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> change(%{roles: ["admin"]})
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
