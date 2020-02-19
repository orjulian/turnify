defmodule Turnify.Accounts do
  @moduledoc """
  The Accounts context.
  """

  require IEx
  import Ecto.Query, warn: false
  alias Turnify.{Repo, Calendars.Calendar}
  alias Turnify.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a basic user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates an user with "patient" role associated. No extra attributes needed.
  """
  def create_patient(attrs \\ %{}) do
    %User{}
    |> User.patient_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates an user with "professional" role associated. No extra attributes needed.
  """
  def create_professional(attrs \\ %{}) do
    %User{}
    |> User.professional_changeset(attrs)
    |> Repo.insert!()
    |> Repo.preload(:calendar)
    |> put_user_assoc(:calendar, %Calendar{})
  end

  @doc """
  Creates an user with "admin" role associated. No extra attributes needed.
  """
  def create_admin(attrs \\ %{}) do
    %User{}
    |> User.admin_changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns a %Struct{}, the one belonging to the record that's being created.

  The assoc param refers to the association being created, 
  and the set param refers to a struct containing its attributes
  ## Examples

    iex> put_user_assoc(user, :company, %Turnify.Entities.Company{name: "Testing"})
    %Turnify.Entities.Company{}
  """
  def put_user_assoc(user, assoc, set) do
    user
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(assoc, set)
    |> Repo.update
  end
end
