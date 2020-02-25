# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :turnify,
  ecto_repos: [Turnify.Repo]

# Configures the endpoint
config :turnify, TurnifyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/jaquHafbEbGYyRfjAZr5DOwVHObICYRUSqAXgw+wYZIF3lwRv8M9a4X0wpvG21o",
  render_errors: [view: TurnifyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Turnify.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :turnify, Turnify.Guardian,
  issuer: "Turnify",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "kZTqvzBVDX3HKQM1WxA0TRysmyjP0fqYxPa7ZWXqRVqetgLcGr93pdu6QmWNoHu"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

import_config "#{Mix.env()}.exs"
