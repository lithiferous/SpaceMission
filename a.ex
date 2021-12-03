[ok: 
  %SpaceMission.Schemas.Stage{
    __meta__: #Ecto.Schema.Metadata<:loaded, "stages">,
    id: 1, inserted_at: ~N[2021-12-03 00:35:19],
    planet:
      %SpaceMission.Schemas.Planet{
        __meta__: #Ecto.Schema.Metadata<:loaded, "planets">,
        gravity: 9.807, id: 1, name: "earth"},
        planet_id: 1,
        trip: %SpaceMission.Schemas.Trip{__meta__: #Ecto.Schema.Metadata<:loaded, "trips">,
          id: 1, inserted_at: ~N[2021-12-03 00:35:19],
          mass: 28801,
          stage: #Ecto.Association.NotLoaded<association :stage is not loaded>,
          updated_at: ~N[2021-12-03 00:35:19]},
          trip_id: 1,
          type: :launch,
          updated_at: ~N[2021-12-03 00:35:19]},
  ok: %SpaceMission.Schemas.Stage{__meta__: #Ecto.Schema.Metadata<:loaded, "stages">,
    id: 2, inserted_at: ~N[2021-12-03 00:35:19],
    planet: %SpaceMission.Schemas.Planet{__meta__: #Ecto.Schema.Metadata<:loaded, "planets">, gravity: 1.62, id: 2, name: "moon"}, planet_id: 2, trip: %SpaceMission.Schemas.Trip{__meta__: #Ecto.Schema.Metadata<:loaded, "trips">, id: 1, inserted_at: ~N[2021-12-03 00:35:19], mass: 28801, stage: #Ecto.Association.NotLoaded<association :stage is not loaded>, updated_at: ~N[2021-12-03 00:35:19]}, trip_id: 1, type: :land, updated_at: ~N[2021-12-03 00:35:19]}, ok: %SpaceMission.Schemas.Stage{__meta__: #Ecto.Schema.Metadata<:loaded, "stages">, id: 3, inserted_at: ~N[2021-12-03 00:35:19], planet: %SpaceMission.Schemas.Planet{__meta__: #Ecto.Schema.Metadata<:loaded, "planets">, gravity: 1.62, id: 2, name: "moon"}, planet_id: 2, trip: %SpaceMission.Schemas.Trip{__meta__: #Ecto.Schema.Metadata<:loaded, "trips">, id: 1, inserted_at: ~N[2021-12-03 00:35:19], mass: 28801, stage: #Ecto.Association.NotLoaded<association :stage is not loaded>, updated_at: ~N[2021-12-03 00:35:19]}, trip_id: 1, type: :launch, updated_at: ~N[2021-12-03 00:35:19]}, ok: %SpaceMission.Schemas.Stage{__meta__: #Ecto.Schema.Metadata<:loaded, "stages">, id: 4, inserted_at: ~N[2021-12-03 00:35:19], planet: %SpaceMission.Schemas.Planet{__meta__: #Ecto.Schema.Metadata<:loaded, "planets">, gravity: 9.807, id: 1, name: "earth"}, planet_id: 1, trip: %SpaceMission.Schemas.Trip{__meta__: #Ecto.Schema.Metadata<:loaded, "trips">, id: 1, inserted_at: ~N[2021-12-03 00:35:19], mass: 28801, stage: #Ecto.Association.NotLoaded<association :stage is not loaded>, updated_at: ~N[2021-12-03 00:35:19]}, trip_id: 1, type: :land, updated_at: ~N[2021-12-03 00:35:19]}]

