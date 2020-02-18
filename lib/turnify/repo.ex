defmodule Turnify.Repo do
  use Ecto.Repo,
    otp_app: :turnify,
    adapter: Ecto.Adapters.Postgres
end
