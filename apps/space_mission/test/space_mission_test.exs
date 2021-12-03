defmodule SpaceMissionTest do
  use ExUnit.Case
  doctest SpaceMission

  test "greets the world" do
    assert SpaceMission.hello() == :world
  end
end
