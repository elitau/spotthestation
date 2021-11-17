import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spotthestation2, Spotthestation2Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wp9wR27peogP7d7gQxVhoof9ToLcFlvZLOgPIX73moNcT18TI3gY9MhtLk/FpRy/",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
