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
1. Mit dem Befehl wird das Image aus dem Dockerhub heruntergeladen.
```bash
  docker pull zweipunkt/ci
```

2. Sie starten den Container mit einern Terminal/Konsole.
```bash
  docker run --rm -it -v /paht/on/host:/src zweipunkt/ci bash
```
 - --rm -> entfert den Container nachdem er seine Aufgabe erfüllt hat
 -  -it -> interaktiver Container 
 -  -v  -> Speicher mit Zwei Pfaden von Host-Filesystem : nach Container-Filesystem
 -  bash -> Container Interne Terminal

3. Ist der Container gestartet müssen Sie mit
```bash
  nano run.sh
```
&nbsp;&nbsp;&nbsp;&nbsp;das Script bearbeiten in der Zeile bearbeiten.
```bash
  php -d memory_limit=4G vendor/bin/phpmd /path/to/code ansi source/phpmd.xml
```
&nbsp;&nbsp;&nbsp;&nbsp;Hierbei wird /path/to/code mit dem Pfad ersetzt wo der Quelltext liegt beginnend mit /src/source/.../.. <br>
&nbsp;&nbsp;&nbsp;&nbsp;Ist der Pfad richtig müssen folgende Shortcuts nacheinander gedrückt werden

Shortcut | Bedeutung
------------ | -------------
CTRL / STRG / Command + O | Speichert die Datei <br> Fragt aber nach einem Namen der Datei <br> Einfach Enter drücken
CTRL / STRG / Command + X | Beendet Nano (Den Terminal Texteditor)

4. Nur noch 
```bash
./run.sh
```
&nbsp;&nbsp;&nbsp;&nbsp;eintippen und die Test's werden Automatisch durchlaufen.<br>
&nbsp;&nbsp;&nbsp;&nbsp;Ist jeder Test abgeschlossen so wird im Terminal die Fehler, welche sich im Quelltext befinden aufgelistet.
