defmodule SpaceMission do
  alias SpaceMission.{Planets, Stages}

  # def run(trips) do
  #   Enum.map(trips, fn {mass, stages} ->
  #     elem(load_stages(stages)
  #     |> elem(1)
  #     |> Enum.map(fn s ->
  #       SpaceMission.create_trip(
  #         %{mass: mass},
  #         s.id
  #       )
  #     end)
  #   end)
  # end

  def load_stages(stages) do
    Enum.map(stages, fn {type, gravity, trip_id} ->
      case Stages.create(
             %{type: type},
             Enum.find_value(Planets.list(), fn p ->
               if p.gravity == gravity, do: p.id
             end),
             trip_id
           ) do
        {:error, text} -> {:error, text}
        {:ok, schema} -> Map.from_struct(schema)
      end
    end)
  end
end
