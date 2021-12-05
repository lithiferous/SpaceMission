defmodule SpaceMission.PathFinder do
  alias SpaceMission.Planets

  @moduledoc """
  Path validation utility to ensure that every incoming `SpaceMission.Stage.type` atom is followed by it's counter part, so that we do not perform multiple launches without landing and vice versa. In addition it checks the fact that after landing we launch from the same planet.
  """
  @doc """
  Wrapper function that instantiates the graph accumulator and launches the recursive traversal.

  Returns `{:ok, nil}`.

  ## Examples

      iex> stages = Stages.list
      iex> PathFinder.path_valid?(stages)
      {:ok, nil}

  """
  def path_valid?(stages) do
    Graph.new()
    |> fill(stages)
  end

  defp fill(g, [head, next | tail]) do
    verts = g |> Graph.vertices()

    cond do
      # perform a check that next element is not the same; It would mean we perform two consequent launches/lands which is impossible
      head.type == next.type ->
        {:error,
         "You cannot perform another #{next.type} twice, you have enough fuel only to do #{head.type} for #{head.planet.name}"}

      head.type != next.type ->
        # perform a check that after landing on one planet we do not launch from another oneA
        case head.type == :land and
               head.planet.id != next.planet.id do
          true ->
            {:error,
             "You cannot perform landing on #{head.planet.name} and launch from #{next.planet.name}. In case you inveneted a teleport, please, contact us @nssc-contactcenter@nasa.gov"}

          false ->
            case tail != [] and tail != nil do
              true ->
                g
                |> Graph.add_edge(
                  {head.type, head.planet.id},
                  {next.type, next.planet.id}
                )
                |> fill([next | tail])

              false ->
                {:ok, nil}
            end
        end

      true ->
        {:error, "Passed object should be of the form `[%SpaceMission.Schemas.Stage{}]`"}
    end
  end
end
