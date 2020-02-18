defmodule TurnifyWeb.Resolvers.User do
  alias Turnify.{Repo, Guardian, Accounts.User}

  import Comeonin.Bcrypt, only: [checkpw: 2]

  # We query all users only if current_user is logged in
  def all_users(_root, _args, %{ context: %{ current_user: current_user, company: company } }) do
    users = Repo.all(User)
    { :ok, users }
  end

  # We handle missing current_user
  def all_users(_root, _args, _info) do
    { :error, "Unauthorized" }
  end

  def sign_in(_root, args, _info) do
    user = Repo.get_by!(User, email: args.email)

    cond do
      user && checkpw(args.password, user.encrypted_password) ->
        { :ok, token, _claims } = Guardian.encode_and_sign(user)
        { :ok, _ } = User.store_token(user, token)
        { :ok, %{ token: token } }
      user ->
        { :error, %{} }
    end
  end

  def create_user(_root, args, _info) do
    user = User.changeset(%User{}, args)
    user = Repo.insert(user)

    user
  end
end
