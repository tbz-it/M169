Modul 169 Services mit Containern bereitstellen
==================================

Container Umgebung.

Verwendete Produkte
-------------------
* [docker](https://www.docker.com/)
* [podman](https://podman.io/)
* [microk8s](https://microk8s.io/) (Kubernetes)

Docker in Docker
----------------

Innerhalb von microk8s läuft ein Docker in Docker Container.

Dieser dient zum Builden vom Container Images vom lokalen PC/Notebook.

Dabei ist wie folgt vorzugehen
* Docker CLI von [hier](https://download.docker.com/win/static/stable/x86_64/) downloaden und nur docker.exe ablegen
* Umgebungsvariable DOCKER_HOST auf ${ADDR):2375 setzen
* Docker ausprobieren, z.B. mittels `docker run hello-world`

Die Arbeiten sind auf dem lokalen PC/Notebook auszuführen.

Zusätzlich zum Port 2375 sind noch die Ports 8080 - 8089 geöffnet und können zum Testen von Container verwendet werden, z.B.:

	docker run --name hello-world -d -p 8080:80 registry.gitlab.com/mc-b/misegr/hello-world
	
Zugriff auf Container Web UI mittels http://${ADDR}:8080