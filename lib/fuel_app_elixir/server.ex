defmodule FuelAppElixir.Server do
  use GenServer

  alias FuelAppElixir.Tools

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  @spec init(any()) :: {:ok, 0}
  def init(_), do: {:ok, 0}

  @spec calculate(Tools.mass(), Tools.routes()) :: {:reply, non_neg_integer(), non_neg_integer()}
  def calculate(mass, routes) do
    GenServer.call(__MODULE__, {:calculate, {mass, routes}})
  end

  @impl true
  def handle_call({:calculate, {mass, routes}}, _from, state) do
    result = state + Tools.calculate(mass, routes)
    {:reply, result, 0}
  end
end
