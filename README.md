# CI-Tool von ZweiPunkt GmbH

## Ihre Agentur für ein erfolgreiches Online Projekt.<br><br>Als Full-Service Shopware Agentur bieten wir Ihnen alles aus einer Hand. Wir betreuen Sie und Ihr Projekt von Beginn an und sorgen für den erfolgreichen Start Ihres E-Commerce Projektes.

Mit dieser Docker Application Gelingt Ihnen die automatische Überprüfung des Quelltextes.

### Verwendete PHP Prüf-Applicationen
Tool | Version
------------ | -------------
PHPStan | 1.4.10
PHPUnit | 9.5.19
PHPMD - PHP Mess Detector | 2.11.1
PHP_CodeSniffer | 3.6.2

## First Steps

1. Die CI Tools setzten eine `ci.txt` in jedem Repository vorraus. In dieser Datei werden alle zu überprüfenden Pfade des Quelltextes hinterlegt.


2. Mit dem Befehl wird das Image aus dem Dockerhub heruntergeladen.
```bash
  docker pull zweipunkt/ci
```

3. Sie starten den Container mit einern Terminal/Konsole.
```bash
  docker run --rm -it -v /paht/on/host:/src zweipunkt/ci
```
 - `--rm -> entfert den Container nachdem er seine Aufgabe erfüllt hat `
 - `-it -> interaktiver Container (Ist optional)`
 - `-v  -> Speicher mit Zwei Pfaden von Host-Filesystem : nach Container-Filesystem`

3. Wenn alle Test durchgelaufen sind, wird im Terminal jede Datei mit einer Zeilennummer und einer Fehlerbeschreibung.