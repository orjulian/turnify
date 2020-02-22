defmodule TurnifyWeb.Router do
  use TurnifyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Corsica, origins: "http://localhost:8080"
  end

  pipeline :graphql do
    plug Corsica,
      origins: ["http://localhost:8080"],
      log: [rejected: :error, invalid: :warn, accepted: :debug],
      allow_headers: ["content-type"],
      allow_credentials: true

    plug Turnify.Context
  end

  scope "/api" do
    pipe_through(:graphql)

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TurnifyWeb.Schema

    forward "/", Absinthe.Plug, schema: TurnifyWeb.Schema
  end
end
