import Config

config :logger,
  backends: [{LoggerFileBackend, :log}]

config :logger, :log,
  path: "../logs/app.log",
  format: "$message\n",
  metadata: [:request_id],
  level: :debug

config :plug_logger_json,
  filtered_keys: ["password", "authorization"],
  suppressed_keys: ["api_version"]
