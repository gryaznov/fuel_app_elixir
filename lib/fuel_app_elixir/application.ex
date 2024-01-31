defmodule FuelAppElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: FuelAppElixir.Worker.start_link(arg)
      # {FuelAppElixir.Worker, arg}
      FuelAppElixir.Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FuelAppElixir.Supervisor]

    # default timeout (5 seconds) and number of restarts (3)
    Supervisor.start_link(children, opts)
  end
end
