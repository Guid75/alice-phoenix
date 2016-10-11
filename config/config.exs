# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :alice, Alice.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "alice_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# General application configuration
config :alice,
  ecto_repos: [Alice.Repo]

# Configures the endpoint
config :alice, Alice.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VOsw2nqFa6NDyuMabt7fseroYMiIoFneb7lhsnI5VuhT2XOwssG2EbeFGn1knGZf",
  render_errors: [view: Alice.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Alice.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
