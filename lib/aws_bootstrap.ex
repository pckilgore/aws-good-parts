defmodule AWS_Bootstrap.Router do
  use Plug.Router
  require Logger
  use Plug.ErrorHandler

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.LoggerJSON, log: :debug)

  plug(:dispatch)

  match("/", to: AWS_Bootstrap.HelloWorldPlug)

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp handle_errors(%Plug.Conn{status: 500} = conn, %{
         kind: kind,
         reason: reason,
         stack: stacktrace
       }) do
    Plug.LoggerJSON.log_error(kind, reason, stacktrace)

    send_resp(
      conn,
      500,
      Poison.encode!(%{
        errors: %{
          detail: "Internal server error"
        }
      })
    )
  end

  defp handle_errors(_, _), do: nil
end

defmodule AWS_Bootstrap.Application do
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: AWS_Bootstrap.Router, options: [port: 8080]}
    ]

    opts = [strategy: :one_for_one, name: AWS_Bootstrap.Supervisor]

    Logger.info("{ \"notice\": \"Starting Application\" }\n")

    Supervisor.start_link(children, opts)
  end
end
