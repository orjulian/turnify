defmodule Turnify.Context do
  @behaviour Plug

  require IEx
  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Turnify.{Accounts.User, Repo}

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         response <- authorize(token) do
      response
    end
  end

  defp authorize(token) do
    User
    |> where(token: ^token)
    |> Repo.one()
    |> Repo.preload(:company)
    |> case do
      nil ->
        {:error, "Invalid authorization token"}

      user ->
        fields = %{current_user: user, token: token}

        fields =
          if(user.company, do: Map.put_new(fields, :current_company, user.company), else: fields)

        {:ok, fields}
    end
  end
end
