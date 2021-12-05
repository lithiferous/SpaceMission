name = "space_mission"

web_create:
	cd apps && mix phx.new.web $(name)_web --no-ecto

web_run:
	mix phx.server

db_create:
	cd apps/${name} && mix ecto.create

db_migrate:
	cd apps/${name} && mix ecto.migrate

db_rollback:
	cd apps/${name} && mix ecto.rollback

db_update:
	cd apps/${name} && mix run priv/repo/seeds.exs

pull_deps:
	mix run deps.get
