import Config

config :space_mission, SpaceMission.Repo,
  database: "space_mission_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :space_mission, ecto_repos: [SpaceMission.Repo]


config :space_mission_web,
  generators: [context_app: false]

# Configures the endpoint
config :space_mission_web, SpaceMissionWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SpaceMissionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SpaceMissionWeb.PubSub,
  live_view: [signing_salt: "5bLwFvD5"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/space_mission_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :space_mission,
  generators: [context_app: false]

# Configures the endpoint
config :space_mission, SpaceMission.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SpaceMission.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SpaceMission.PubSub,
  live_view: [signing_salt: "Lpi5AqqH"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/space_mission/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
