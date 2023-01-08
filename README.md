Modul 169 Services mit Containern bereitstellen
==================================

Container Umgebung.

Verwendete Produkte
-------------------
* [docker](https://www.docker.com/)
* [podman](https://podman.io/)
* [microk8s](https://microk8s.io/) (Kubernetes)

Docker
------

Docker kann in der VM sowie vom lokalen Notebook aus verwendet werden. Allerdings sind es zwei Instanzen, d.h. Docker Container/Images sind nur in der einen oder anderen Umgebung sichtbar.

### VM

Einloggen via SSH oder Shell in a Box in die VM.

Einfacher Container starten:

    docker run --name hello-world -d -p 8091:80 registry.gitlab.com/mc-b/misegr/hello-world
    
Die Webseite des Containers kann mittels http://${ADDR}:8091 angezeigt werden.

### Lokaler Notebook

Diese Umgebung ist zum Builden und einfachen Tests von Containern gedacht. 

* Docker CLI von [hier](https://download.docker.com/win/static/stable/x86_64/) downloaden und nur docker.exe ablegen
* Umgebungsvariable DOCKER_HOST auf tcp://${ADDR}:2375 setzen

Einfacher Container starten:

    docker run --name hello-world -d -p 8080:80 registry.gitlab.com/mc-b/misegr/hello-world
    
Die Webseite des Containers kann mittels http://${ADDR}:8080 angezeigt werden.

**ACHTUNG**: weil diese Docker Umgebung als "Docker in Docker" läuft, sind nur Ports 8080 - 8089 verfügbar.

**Container Image builden**

Datei `index.php`mit folgendem Inhalt erstellen:

    <?php echo '<p>Ich bin in einem Container am laufen</p>'; ?>

Datei `Dockerfile` mit folgendem Inhalt erstellen:

    FROM public.ecr.aws/docker/library/php:7.4-apache
    COPY index.php /var/www/html/
   
Alles in ein Container Image verpacken:

    docker build -t myservice .
    
Container starten:

    docker run --name myservice -d -p 8081:80 myservice
    
Die Webseite des Containers kann mittels http://${ADDR}:8081 angezeigt werden.    

Podman
------

Podman ist eine "sichere" Alternative zu Docker.

Die Befehle von Docker und Podman sind identisch. Podman läuft nur in der VM!

Einloggen via SSH oder Shell in a Box in die VM.

Einfacher Container starten:

    podman run --name hello-world -d -p 8100:80 registry.gitlab.com/mc-b/misegr/hello-world
    
Die Webseite des Containers kann mittels http://${ADDR}:8100 angezeigt werden.

microk8s (Kubernetes)
---------------------

Ist eine Kubernetes Distrubution für Ubuntu.

Die Umgebung ist so konzipiert, dass das Kubernetes CLI `kubectl` in der VM oder vom lokalen Notebook funktionert.

### VM

Einloggen via SSH oder Shell in a Box in die VM.

Einfacher Container starten:

    kubectl run hello-world --image registry.gitlab.com/mc-b/misegr/hello-world --restart=Never 
    kubectl expose pod/hello-world --type="LoadBalancer" --port 80

Anzeige laufender Container inkl. Service 

    kubectl get all
    
Die Webseite des Containers kann mittels http://${ADDR}:<gemappter Port> angezeigt werden.

### Lokaler Notebook
    
Einloggen via SSH oder Shell in a Box in die VM.

Eingabe von:

    microk8s config view

Der angezeigte Inhalt auf dem Notebook im Home Verzeichnis als Datei `.kube/config` speichern. 

Anschliessend IP-Adresse im Eintrag `server:` auf ${ADDR} ändern und das `kubectl` CLI auf dem Notebook herunterladen, siehe [hier](https://kubernetes.io/docs/tasks/tools/).

Nun kann das `kubectl` CLI wie in der VM verwendet werden.

