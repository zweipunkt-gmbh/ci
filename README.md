# CI-Tool von ZweiPunkt GmbH

### Ihre Agentur für ein erfolgreiches Online Projekt.  
Als Full-Service Shopware Agentur bieten wir Ihnen alles aus einer Hand.  
Wir betreuen Sie und Ihr Projekt von Beginn an und sorgen für den erfolgreichen Start Ihres E-Commerce Projektes.  

---
Mit dieser Docker Applikation gelingt Ihnen die automatische Überprüfung des Quelltextes.

### Verwendete PHP Prüf-Applikationen
| Tool                      | Version |
|---------------------------|---------|
| PHPStan                   | 1.4.10  |
| PHPUnit                   | 9.5.19  |
| PHPMD - PHP Mess Detector | 2.11.1  |
| PHP_CodeSniffer           | 3.6.2   |

## First Steps

1. Die CI Tools setzten eine `ci.txt` in jedem Repository voraus. In dieser Datei werden alle zu überprüfenden<br>
Pfade des Quelltextes hinterlegt.


2. Mit dem Befehl wird das Image aus dem Dockerhub heruntergeladen.
```bash
  docker pull zweipunkt/ci
```

3. Sie starten den Container mit einem Terminal/Konsole.
```bash
  docker run --rm -it -v /paht/on/host:/src zweipunkt/ci
```
- `docker` -> Applikation die angesprochen wird (Ähnlich der notepad.exe auf Windows das Notepad startet)
- `run` -> Befehl der in der Applikation ausgeführt wird
- Optionen
  - `--rm` -> entfernt den Container, nachdem er seine Aufgabe erfüllt hat 
  - `-it` -> interaktiver Container (Ist optional)
  - `-v`  -> Speicher mit zwei Pfaden von Hostsystem zu Container-Dateisystem
- 

3. Wenn alle Test durchgelaufen sind, wird im Terminal jede Datei mit einer Zeilennummer und einer Fehlerbeschreibung.  

   ---

   

## Commands für Lokale Entwicklungsumgebung

1. Der Docker Befehl um Lokal ein Image aus der Dockerfile zu bauen
```bash
docker build -t zweipunkt/ci:1.1.0 .
```
- `docker` -> Applikation die angesprochen wird (Ähnlich der calc.exe auf Windows die den Taschenrechner startet)
- `build` -> Befehl der in der Applikation ausgeführt wird
- Optionen
  - `-t` -> so kann dem Image einen Namen bzw. tag gegeben werden z.B. `-t helloworld`
  - `:x.y.z` hinter dem Namen ist die Versions-Nr. in welcher das Image vorliegt z.B. `helloworld:1.4.8`
- `.` -> sucht nach einer `Dockerfile` im aktuellen Verzeichnis aus dem ein Image erstellt werden k

2. Weitere Schritte sind aus `First Steps Punkt 2`zu entnehmen   

   

## Images auf `Docker Hub` oder `self-Hosted Repositories` pushen

- Anmeldung via `docker login` im Terminal sofern Zugangsdaten vorhanden wenn nicht den Administrator Informieren

1.  Anhand der ID den Contaqiner in ein neues Image speichern

```bash
docker container commit c16378f943fe foo-bar:1.0.5
```

| Optionen     | Bedeutung                                                                                  |
|--------------|--------------------------------------------------------------------------------------------|
| container    | Befehl um Container anzusprechen                                                           |
| commit       | 	                                                                                          |
| c16378f943fe | Das ist die Container-ID der in das neue Image hinzugefügt werden soll. (Nur ein Beispiel) |
| foo-bar      | Name des Images worin der Container gespeichert wird                                       |
| 1.0.5        | Versions-Nr. des Images (`latest`als Version kann auch verwendet werden z.B. `php:7.4`)    |

    Hinter der VersionsNr. wird oft die Basis angehängt auf dem das Containerimage basiert

- Um die Container-ID herauszufinden müssen sie den Befel eingeben
  - `docker container ls` -> ruft Programm Docker auf, spricht die Container an und listet sie alle auf

2. Jetzt muss das Image im Repository eingetragen werden mit
```bash
  docker image tag zweipunkt/ci:1.1.0 zweipunkt/zweipunkt/ci:1.1.0
```
- `tag` -> sucht nach einem Image mit dem tag der mit einem Leerzeichen getrennt folgt
- nach dem tag gibt man an wo es registriert werden soll. Im unserem Fall wird es im `Docker Hub` registriert

3. Nun muss man nur noch das registrierte Image in die Regestry pushen
```bash
  docker image push zweipunkt/zweipunkt/ci:1.1.0
```

- `push` schiebt das lokale image auf `Docker Hub` oder ein `self-Hosted Repository`
- `zweipunkt/` ist der Accountname wo das ganze veröffentlicht wird
- `zweipunkt/ci` ist der Name des öffentlichen images
- `1.1.0` ist die Version des Images