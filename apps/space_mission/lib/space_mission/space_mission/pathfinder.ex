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
            g
            |> Graph.add_edge(
              {head.type, head.planet.id},
              {next.type, next.planet.id}
            )
            |> fill([next | tail])
        end

      true ->
        {:error, "Passed object should be of the form `[%SpaceMission.Schemas.Stage{}]`"}
    end
  end

  defp fill(g, [next]) do
    # take last vertice in the graph as head
    {head_type, head_planet_id} =
      g
      |> Graph.vertices()
      |> Enum.reverse()
      |> hd()

    head_planet_name = Planets.get(head_planet_id)

    cond do
      # means we have a single element list, which is an appropriate path. I would stay on Moon too, for that matter
      head_type == nil ->
        {:ok, nil}

      head_type == next.type ->
        {:error,
         "You cannot perform another #{next.type} twice, you have enough fuel only to do #{head_type} for #{head_planet_name}"}

      head_type != next.type ->
        case head_type == :land and
               head_planet_id != next.planet.id do
          true ->
            {:error,
             "You cannot perform landing on #{head_planet_name} and launch from #{next.planet.name}. In case you inveneted a teleport, please, contact us @nssc-contactcenter@nasa.gov"}

          false ->
            g
            |> Graph.add_edge(
              {head_type, head_planet_id},
              {next.type, next.planet.id}
            )
            |> fill([])
        end
    end
  end

  defp fill(_g, []), do: {:ok, nil}
end
