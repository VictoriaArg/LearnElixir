defmodule GraphqlAssignmentWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :graphql_assignment

  socket("/socket", GraphqlAssignmentWeb.UserSocket, websocket: true, longpoll: false)

  if code_reloading? do
    plug(Phoenix.CodeReloader)
  end

  plug(Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"
  )

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(GraphqlAssignmentWeb.Router)
end
