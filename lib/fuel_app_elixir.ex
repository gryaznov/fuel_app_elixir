defmodule FuelAppElixir do
  @moduledoc """
  Calculates an amount of fuel required for the flight according to the given route.
  """
  alias FuelAppElixir.Tools

  @doc """
  Calculates an amount of fuel required for the given route.
    ##Examples:
      iex> FuelAppElixir.perform(28801, [{:land, 9.807}])
      13447

      iex> FuelAppElixir.perform(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      51898

      iex> FuelAppElixir.perform(14606, [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
      33388

      iex> FuelAppElixir.perform(75432, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
      212161
  """
  @spec perform(Tools.mass(), Tools.routes()) :: {:reply, non_neg_integer(), non_neg_integer()}
  def perform(mass, routes) do
    FuelAppElixir.Server.calculate(mass, routes)
  end
end
