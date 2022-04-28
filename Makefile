USERNAME = zamazzal
DOCKERCOMPOSE_PATH = srcs/docker-compose.yml
ENVVAR_PATH = srcs/.env
VOLUMES_PATH = /home/$(USERNAME)/data

all:
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) up -d --build
start:
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) start
stop:
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) stop
clean:
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) down
	rm -rf /home/zamazzal/data/
fclean:
	docker stop $(docker ps -qa)
	docker rm $(docker ps -qa)
	docker rmi -f $(docker images -qa)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls -q) 2>/dev/null

re: clean all
