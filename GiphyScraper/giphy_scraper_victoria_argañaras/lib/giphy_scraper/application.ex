defmodule GiphyScraper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Dotenv

  @impl true
  def start(_type, _args) do
    Dotenv.load()

    children = [
      {Finch, name: MyFinch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GiphyScraper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
