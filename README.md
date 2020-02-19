# Turnify

To start your Phoenix server with Docker:

  * Run `docker-compose -f development.yml build`
  * Create and migrate your database with `docker-compose -f development.yml run --rm phoenix mix ecto.setup`
  * Start Phoenix endpoint with `docker-compose -f development.yml run --rm --service-ports phoenix` in order to have access to `IEx.pry`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Roadmap

### Devops

  * Add busybox volume to store deps.

### Testing

  * Add proper Absinthe testing (still experimenting).

### Features

  * Create mutation to assign new `AvailableDays` to a `Calendar`.
    * Validate that the only one allowed to edit items is the `Calendar` owner.
  * Create query to display `AvailableDays` attached to a `Calendar`.
  * Create `Appointment`, which belongs to `Calendar` (one-to-many), and to `User` through `Calendar`.
  * Create the `Patient` validations, which will apply after an `Appointment` is setted. If a `Patient` already exists in the database, that one will be used, otherwise a new one will be created.
    * `Patients` will **only** be created after an `Appointment`, at least for the moment.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
