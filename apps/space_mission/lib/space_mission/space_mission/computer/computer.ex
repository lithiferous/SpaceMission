defmodule SpaceMission.Computer do
  @moduledoc """
  Interface for computing different NASA tasks
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
  def compute_mass_of_fuel_for_mass(stage, mass, gravity) do
    trunc(
      case stage do
        :launch -> launch(mass, gravity)
        :land -> land(mass, gravity)
      end
    )
  end

  @doc """
  Computes fuel mass for fuel itself.
  """
  def compute_mass_of_fuel_for_fuel_mass(type, mass, gravity, acc) do
    mass = compute_mass_of_fuel_for_mass(type, mass, gravity)

    cond do
      mass < 0 -> acc
      true -> compute_mass_of_fuel_for_fuel_mass(type, mass, gravity, acc + mass)
    end
  end

  @doc """
  Checks if space journey is possible in our universe.
  """
  def is_path_direct?(stages) do
    Graph.new()
    |> SpaceMission.PathCalculator.fill(stages)
  end
end

defmodule SpaceMission.PathCalculator do
  def fill(g, [head, next | tail]) do
    if head.type == next.type do
      {:error, "You cannot perform #{head.type} twice, you have enough fuel only for one"}
    else
      g
      |> Graph.add_edge({head.type, head.planet.id}, {next.type, next.planet.id})
      |> fill(tail)
    end
  end

  def fill(g, [next]) do
    head = hd(Enum.reverse(Graph.vertices(g)))

    g
    |> Graph.add_edge({head.type, head.planet.id}, {next.type, next.planet.id})
    |> fill([])
  end

  def fill(g, []), do: g
end
