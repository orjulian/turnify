# Turnify

To start your Phoenix server with Docker:

  * Run `docker-compose -f development.yml build`
  * Create and migrate your database with `docker-compose -f development.yml run --rm phoenix mix ecto.setup`
  * Start Phoenix endpoint with `docker-compose -f development.yml run --rm --service-ports phoenix iex -S mix phx.server` in order to have access to `IEx.pry`, otherwise run `docker-compose -f development.yml up` to start the server without access to the interactive console.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Roadmap

### Devops

  * Add script to run `mix deps.get` inside compose up.
  * Add busybox volume to store deps.

### Testing

  * Add proper Absinthe testing (still experimenting).

### Features

  * Create `AvailableDays`, which belogs to `User` (one-to-many). An `User` will have a set of available days to work, each one with a list of hours, that will be used later to assign `Appointments`.
  * Create `Calendar`, which belongs to `User` (one-to-one). A Professional has one Calendar and a `Calendar` belongs to one `User`.
  * Create `Appointment`, which belongs to `Calendar` (one-to-many), and to `User` through `Calendar`.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
