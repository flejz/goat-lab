homeassistant-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' homeassistant

zigbee2mqtt-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zigbee2mqtt

adguard-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' adguard

up:
	docker-compose up -d

down:
	docker-compose up -d
