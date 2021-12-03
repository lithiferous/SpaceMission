import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :space_mission_web, SpaceMissionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Rcag54vmCHDrs0zxUMdwWn7+NgR7T9tWVLrPgcNhqYKGmYcYBvrLB7OlstM3RpgG",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :space_mission, SpaceMission.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "EJd1Jv3eS2GZ9mEqmjitg9giZvnIQimNuut6YVA4vc81FT7fZHMZz9hFxVjXBbvh",
  server: false
