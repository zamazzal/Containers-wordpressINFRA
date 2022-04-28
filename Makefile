USERNAME = zamazzal
DOCKERCOMPOSE_PATH = srcs/docker-compose.yml
ENVVAR_PATH = srcs/.env
VOLUMES_PATH = /home/$(USERNAME)/data

all :
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) up -d --build
start :
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) start
stop :
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) stop
clean:
	docker-compose -f $(DOCKERCOMPOSE_PATH) --env-file $(ENVVAR_PATH) down
	sudo rm -rf /home/zamazzal/data/

init:
	sudo echo "127.0.0.1	$(USERNAME).42.fr" >> /etc/hosts
	sudo echo "127.0.0.1	adminer-$(USERNAME).42.fr" >> /etc/hosts
	sudo echo "127.0.0.1	staticweb-$(USERNAME).42.fr" >> /etc/hosts

re: clean all