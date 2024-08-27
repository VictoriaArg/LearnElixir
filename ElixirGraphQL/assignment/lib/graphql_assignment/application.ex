defmodule GraphqlAssignment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Dotenv.load()
    Mix.Task.run("loadconfig")

    children = [
      GraphqlAssignment.Repo,
      # Start the Telemetry supervisor
      GraphqlAssignmentWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: :my_pubsub},
      # Start the Endpoint (http/https)
      GraphqlAssignmentWeb.Endpoint,
      # Start a worker by calling: GraphqlAssignment.Worker.start_link(arg)
      # {GraphqlAssignment.Worker, arg}
      {Absinthe.Subscription, GraphqlAssignmentWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GraphqlAssignment.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GraphqlAssignmentWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
