defmodule SpaceMission.Computer do
  @moduledoc """
  Interface for computing different NASA tasks
  Computes fuel mass for a given equipment mass along with weight of fuel itself.
  """
  @doc """
  Calculates mass value for launching a rocket.
  """
  def launch(mass, gravity) do
    mass * gravity * 0.042 - 33
  end

  @doc """
  Calculates mass value for landing.
  """
  def land(mass, gravity) do
    mass * gravity * 0.033 - 42
  end

  @doc """
  Computes fuel mass for a given stage atom <launch, land>.
  """
  def compute_mass_of_fuel_for_mass(mass, type, gravity) do
    trunc(
      case type do
        :launch -> launch(mass, gravity)
        :land -> land(mass, gravity)
      end
    )
  end

  @doc """
  Computes fuel mass for fuel itself.
  """
  def compute_mass_of_fuel_for_fuel_mass(mass, type, gravity, acc) do
    mass = compute_mass_of_fuel_for_mass(mass, type, gravity)

    cond do
      mass < 0 -> acc
      true -> compute_mass_of_fuel_for_fuel_mass(mass, type, gravity, acc + mass)
    end
  end
end
