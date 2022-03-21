# CI-Tool von ZweiPunkt GmbH

## Ihre Agentur für ein erfolgreiches Online Projekt.<br>Als Full-Service Shopware Agentur bieten wir Ihnen alles aus einer Hand. Wir betreuen Sie und Ihr Projekt von Beginn an und sorgen für den erfolgreichen Start Ihres E-Commerce Projektes.

Mit dieser Docker Application automatisieren Sie die Überprüfung des Quelltextes.

### Verwendete PHP Prüfapplikationen
Tool | Version
------------ | -------------
PhpStan | 1.4.10
PphUnit | 9.5.19
PphMD | 2.11.1
Pph_CodeSniffer | 3.6.2

## First Steps
```bash
docker pull zweipunkt/ci
```
Mit diesem Befehl wir das Image aus dem Dockerhub heruntergeladen.

```bash
docker run --rm -it -v /paht/on/host:/src zweipunkt/ci bash
```
Startet den Container mit der bash-shell und mappt das Host-Verzeichnis in /src im Container

```bash
nano run.sh
```
ber diesen Beehl müssen Sie das run Script bearbeiten und den Pfad für PhpMD eintragen der Überprüft werden soll.

Nur noch 
```bash
./run.sh
```
und sie erhalten nach kurzer Zeit ein Report über die im Quelltext vorhanden Fehler.
