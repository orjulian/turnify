defmodule TurnifyWeb.Router do
  use TurnifyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug Corsica, origins: "*"
    plug Turnify.Context
  end

  scope "/api" do
    pipe_through(:graphql)

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: TurnifyWeb.Schema

    forward "/", Absinthe.Plug,
      schema: TurnifyWeb.Schema
  end
end
