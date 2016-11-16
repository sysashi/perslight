# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :perslight,
  namespace: PL,
  ecto_repos: [PL.Repo]

# Config gettext
config :perslight, PL.Gettext, default_locale: "en"

# Configures the endpoint
config :perslight, PL.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OVyWubCJeg+gitR6W2jGVuRnVOv0RwFEeDVveELRQC7ZH4UbZ26PYcilbUXqOsXt",
  render_errors: [view: PL.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PL.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "prod.secret.exs"
