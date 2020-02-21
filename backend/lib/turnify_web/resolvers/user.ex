defmodule TurnifyWeb.Resolvers.User do
  alias Turnify.{Repo, Guardian}
  alias Turnify.{Accounts, Accounts.User}

  import Comeonin.Bcrypt, only: [checkpw: 2]

  def fetch_user(_root, args, _info) do
    user = Repo.get!(User, args[:id])

    user
  end

  def sign_in(_root, args, _info) do
    user = Repo.get_by!(User, email: args.email)

    cond do
      user && checkpw(args.password, user.encrypted_password) ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        {:ok, _} = User.store_token(user, token)
        {:ok, %{token: token}}
      user ->
        {:error, %{}}
    end
  end

  def create_user(_root, args, _info) do
    user = case args[:role] do
      "patient" -> Accounts.create_patient(args)
      "admin" -> Accounts.create_admin(args)
      "professional" -> Accounts.create_professional(args)
      _ -> {:error, message: "Role is invalid"}
    end

    user
  end
end
