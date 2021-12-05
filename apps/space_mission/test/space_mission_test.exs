defmodule SpaceMissionTest do
  alias SpaceMission.Planets
  use ExUnit.Case
  doctest SpaceMission

  setup_all do
    planets = [
      %{
        name: "earth",
        gravity: 9.807
      },
      %{
        name: "moon",
        gravity: 1.62
      },
      %{
        name: "mars",
        gravity: 3.711
      }
    ]

    _planets = planets |> Enum.map(fn p -> Planets.create(p) end)
  end

  test "Appollo 11" do
    stages = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 9.807}
    ]

    fuel_mass = SpaceMission.compute_fuel({28801, stages})

    assert fuel_mass == 36778
  end

  test "Mission on Mars" do
    stages = [
      {:launch, 9.807},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    fuel_mass = SpaceMission.compute_fuel({14606, stages})

    assert fuel_mass == 21060
  end

  test "Passenger ship" do
    stages = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    fuel_mass = SpaceMission.compute_fuel({75432, stages})

    assert fuel_mass == 121_785
  end

  test "Landing on one planet, launching from the other" do
    stages = [
      {:launch, 9.807},
      {:land, 3.711},
      {:launch, 9.807},
      {:land, 9.807}
    ]

    try do
      {status, _} = SpaceMission.compute_fuel({14606, stages})
    rescue
      e in RuntimeError -> true
    end
  end

  test "Multiple launches" do
    stages = [
      {:launch, 9.807},
      {:launch, 3.711},
      {:launch, 9.807},
      {:land, 9.807}
    ]

    try do
      {status, _} = SpaceMission.compute_fuel({14606, stages})
    rescue
      e in RuntimeError -> true
    end
  end
end
