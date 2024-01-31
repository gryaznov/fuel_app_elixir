defmodule FuelAppElixir.Tools do
  @moduledoc """
  Tools and helper functions for fuel calculations.
  """
  @type mass() :: non_neg_integer()
  @type gravity() :: float()
  @type direction() :: :launch | :land
  @type route() :: {direction(), gravity()}
  @type routes() :: [route()]

  @launch_rate 0.042
  @land_rate 0.033

  @spec calculate(mass(), routes()) :: non_neg_integer()
  def calculate(mass, routes) do
    routes
    |> Enum.reverse()
    |> Enum.reduce(0, fn route, fuel ->
      mass
      |> Kernel.+(fuel)
      |> base_fuel(route)
      |> extra_fuel(route)
      |> Kernel.+(fuel)
    end)
  end

  @spec base_fuel(mass(), route()) :: integer()
  defp base_fuel(mass, {:launch, gravity}) do
    (mass * gravity * @launch_rate - @land_rate * 1000) |> floor()
  end

  defp base_fuel(mass, {:land, gravity}) do
    (mass * gravity * @land_rate - @launch_rate * 1000) |> floor()
  end

  @spec extra_fuel(integer(), route()) :: integer()
  defp extra_fuel(fuel_mass, route), do: extra_fuel(fuel_mass, route, [])

  @spec extra_fuel(integer(), route(), [integer()]) :: integer()
  defp extra_fuel(fuel_mass, _, acc) when fuel_mass <= 0, do: Enum.sum(acc)

  defp extra_fuel(fuel_mass, route, acc) do
    fuel_mass
    |> base_fuel(route)
    |> extra_fuel(route, [fuel_mass | acc])
  end
end
