# base image elixer to start with
FROM elixir:1.10.0

# install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# install the latest phoenix 
RUN wget https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN mix archive.install ./phx_new.ez

# create app folder
RUN mkdir /turnify
WORKDIR /turnify
COPY mix.exs .

# install dependencies
RUN mix deps.get

# run phoenix in *dev* mode on port 4000
# CMD mix phx.server
