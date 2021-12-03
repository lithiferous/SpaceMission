webserver_name = "space_mission"

create_web:
	cd apps && mix phx.new.web $(webserver_name)_web --no-ecto

run_web:
	mix phx.server

db_create:
	cd apps/${webserver_name} && mix ecto.create

db_generate:
	cd apps/${webserver_name} && \
		mix ecto.gen.migration create_planets && \
		mix ecto.gen.migration create_rockets && \
		mix ecto.gen.migration create_stages && \
		mix ecto.gen.migration create_trips

db_migrate:
	cd apps/${webserver_name} && mix ecto.migrate

db_rollback:
	cd apps/${webserver_name} && mix ecto.rollback

db_update:
	cd apps/${webserver_name} && mix run priv/repo/seeds.exs

db_visual:
	java -jar /home/ren/schemaspy-6.1.0.jar -t pgsql -dp /usr/share/java/postgresql-jdbc/postgresql-jdbc4.jar -db space_mission_repo -host 127.0.0.1 -port 5432 -u postgres -p postgres -o /home/ren/space_diagram/
