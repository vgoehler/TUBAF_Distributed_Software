<!--

author: Volker G. Göhler

email:  volker.goehler@informatik.tu-freiberg.de

version: 0.0.1

language: de

narrator: Deutsch Male

edit: true
date: 2026
icon: img/TUBAF_Logo_EN_blau.png

logo: 
attribute: 

comment: Distributed Software

import: https://raw.githubusercontent.com/liaScript/mermaid_template/master/README.md

link:   https://raw.githubusercontent.com/vgoehler/LiaScript_CSS_Provider/refs/heads/main/dist/university.css

title: Verteilte Software -- Architektur

tags: Lehre, TUBAF

-->
[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/vgoehler/TUBAF_Distributed_Software/refs/heads/main/vorlesung_01_architektur.md)

# Verteilte Software -- Architektur

**Distributed Software, 2026**

Volker Göhler, TU Bergakademie Freiberg

------------------------------

![Welcome](https://upload.wikimedia.org/wikipedia/commons/0/02/Fig4b_HPCC.jpg "Fvillanustre, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, via Wikimedia Commons")<!-- style="height:300px;" -->

> "Code" auf https://github.com/vgoehler/TUBAF_Distributed_Software als Open Educational Ressource.

----------------------------------------

## Grundlagen & klassische Architekturen

---

<div class="colorbox colorbox--batch">
<div class="colorbox__title">
Lernziele
</div>

Nach dieser Vorlesung können Sie:

- erklären, was eine Softwarearchitektur ist
- verteilte von nicht-verteilten Systemen abgrenzen
- klassische Architekturformen benennen und vergleichen
- erste Architektur-Trade-offs diskutieren
</div>

---

### Was ist eine Softwarearchitektur?

    {{1}}
<div class="colorbox colorbox--hints">
<div class="colorbox__title">
Eine Softwarearchitektur beschreibt:
</div>

- Komponenten
- deren Beziehungen
- grundlegende Designentscheidungen
</div>

   {{2}}
<!-- class="lia-callout--note" -->
>
> Architektur ist keine Implementierung, sondern Struktur und Verantwortung.

---

## Monolithische Architektur
```mermaid @mermaid
flowchart TD
    subgraph Monolith
        UI[Benutzeroberfläche]
        Logic[Geschäftslogik]
        Database[(Datenbank)]
    end
    UI --> Logic
    Logic --> Database
```

Eigenschaften<!-- class="head" -->

- eine Codebasis
- ein Deployment
- direkte Funktionsaufrufe

<!-- class="lia-callout--note" -->
> Sehen Sie dabei Probleme?

### Charakteristika

<section class="flex-container">

<div class="flex-child colorbox--batch">
<div class="colorbox__title head">
Vorteile
</div>

<!-- class="arrow-list arrows-green" -->
- einfach zu verstehen
- leicht zu entwickeln
- einfache Tests

</div>
<div class="flex-child colorbox--errorwf">
<div class="colorbox__title head">
Nachteile
</div>

<!-- class="arrow-list arrows-red" -->
- schlecht skalierbar
- enge Kopplung
- Fehler wirken global
- schwierige Wartung
</div>
</section>

## Client–Server-Architektur

```mermaid @mermaid
flowchart LR
    subgraph Client
        UI[Benutzeroberfläche]
        ClientLogic[Client-Logik]
    end
    subgraph Another Client
        UI2[Benutzeroberfläche 2]
        ClientLogic2[Client-Logik 2]
    end
    subgraph Server
        ServerLogic[Server-Logik]
        Database[(Datenbank)]
    end
    UI <--> ClientLogic
    ClientLogic <--> ServerLogic
    ServerLogic <--> Database
    UI2 <--> ClientLogic2
    ClientLogic2 <--> ServerLogic
```

Idee<!-- class="head" -->

- Aufteilung in Client und Server
- klare Rollenverteilung
- zentrale Datenhaltung
- Kommunikation über Netzwerk
- standardisierte Schnittstellen

<!-- class="lia-callout--note" -->
> Wo finden wir solche Anwendungen?

### Charakteristika

<section class="flex-container">

<div class="flex-child colorbox--batch">
<div class="colorbox__title head">
Vorteile
</div>

<!-- class="arrow-list arrows-green" -->
- bessere Skalierbarkeit
- getrennte Verantwortlichkeiten
- einfachere Wartung
- unabhängige Entwicklung
- verteilte Nutzung
- zentrale Datenhaltung
- standardisierte Schnittstellen

</div>
<div class="flex-child colorbox--errorwf">
<div class="colorbox__title head">
Nachteile
</div>

<!-- class="arrow-list arrows-red" -->
- Netzwerklatenz
- erhöhter Entwicklungsaufwand
- komplexere Tests
- Sicherheitsaspekte
- mögliche Single Points of Failure

</div>
</section>

## 3-Tier-Architektur

```mermaid @mermaid
flowchart LR
    subgraph Group_FE[Front End]
        subgraph Client
            UI[Benutzeroberfläche]
        end
        subgraph Another Client
            Client2[Benutzeroberfläche]
        end
    end
    subgraph Group_MW[Middleware]
        subgraph Application Server
            Web[Webserver / Applikationslogik]
        end
    end
    subgraph Group_BE[Backend]
        subgraph DatabaseServer
            DB[(Datenbank)]
        end
        subgraph DatabaseServer2
            DB2[(Datenbank 2)]
        end
    end
    UI <--> Web
    Web <--> DB
    Web <--> DB2
    Client2 <--> Web

    classDef feStyle fill:#fff4dd,stroke:#d4a017,border:3px dashed #d4a017
    classDef beStyle fill:#e1f5fe,stroke:#01579b,border:3px dashed #01579b
    classDef mwStyle fill:#f3e5f5,stroke:#7b1fa2,border:3px dashed #7b1fa2

    class Group_FE feStyle
    class Group_BE beStyle
    class Group_MW mwStyle
```

Schichten<!-- class="head" -->

1. Präsentation
2. Applikationslogik
3. Persistenz

<!-- class="lia-callout--note" -->
> Was gewinnen wir dadurch?

### Charakteristika

<section class="flex-container">

<div class="flex-child colorbox--batch">
<div class="colorbox__title head">
Vorteile
</div>

<!-- class="arrow-list arrows-green" -->
- hohe Skalierbarkeit
- klare Trennung der Verantwortlichkeiten
- unabhängige Entwicklung
- erleichterte Wartung
- bessere Testbarkeit
- Wiederverwendbarkeit

</div>
<div class="flex-child colorbox--errorwf">
<div class="colorbox__title head">
Nachteile
</div>

<!-- class="arrow-list arrows-red" -->
- erhöhter Entwicklungsaufwand
- komplexere Tests
- Netzwerklatenz
- Sicherheitsaspekte
- mögliche Single Points of Failure
- erhöhter Ressourcenverbrauch

</div>
</section>

## Vergleich klassischer Architekturen
| Architektur | Skalierbarkeit | Wartbarkeit | Komplexität | Deployment |
| :--- | :--- | :--- | :--- | :--- |
| **Monolith** | **Vertikal** (limitiert auf eine Instanz) | **Erschwert** (durch starke Kopplung) | **Niedrig** (einheitliche Codebase) | Einfach (ein Artefakt) |
| **Client-Server** | **Moderat** (Lastverteilung möglich) | **Erhöht** (durch Logik-Trennung) | **Mittel** (Netzwerk-Kommunikation) | Synchronisationsaufwand |
| **3-Tier** | **Hoch** (Layer einzeln skalierbar) | **Gut** (Modular durch klare Schichten) | **Hoch** (Infrastruktur-Overhead) | Komplex (Multi-Stage Release) |

### Und warum ist das jetzt verteilt?

Der entscheidende Unterschied liegt nicht in der Anzahl der Server, sondern in der **Art der Kommunikation** und der **Fehlertoleranz**.

| Merkmal | Nicht-verteilt (Monolith / 3-Tier lokal) | Verteiltes System |
| :--- | :--- | :--- |
| **Adressraum** | Gemeinsamer Speicher (Shared Memory) | Getrennte Adressräume |
| **Kommunikation** | Lokaler Funktionsaufruf (In-process) | Netzwerk-Nachrichten (RPC, REST, Message) |
| **Fehlerfall** | „Alles oder nichts“ (Crash = System aus) | Partielle Ausfälle (Teilsysteme down) |
| **Zeit** | Gemeinsame Systemzeit | Keine globale Uhr (Uhrendrift) |

---

**Die Abgrenzung im Detail**<!-- class="head" -->

* **Monolith / 3-Tier (Klassisch):**

   - Meist eine logische Einheit.
   - Kommunikation zwischen Schichten erfolgt intern.
   - **Vertikale Skalierung:** „Größerer Server“.

* **Verteiltes System:**

   - Komponenten laufen auf unabhängigen Knoten.
   - Koordination ist zwingend erforderlich.
   - **Horizontale Skalierung:** „Mehr Server“.

---

**Visualisierung der Grenze**<!-- class="subhead" -->

```mermaid @mermaid
graph LR
    subgraph Lokal [Zentralisiertes System]
        direction TB
        UI[UI Layer] -- "Function Call" --> Bus[Logic Layer]
        Bus -- "Shared Memory" --> DB[(Database)]
    end

    subgraph Dist [Verteiltes System]
        direction TB
        S1[Service A] <== "Unzuverlässiges Netzwerk" ==> S2[Service B]
        S2 <== "Netzwerk / API" ==> S3[Service C]
    end

    style Lokal fill:#F5F5F5,stroke:#333
    style Dist fill:#E5EDF5,stroke:#004A9A,stroke-width:2px
    style S1 fill:#FFF,stroke:#004A9A
    style S2 fill:#FFF,stroke:#004A9A
    style S3 fill:#FFF,stroke:#004A9A
```

<div class="colorbox colorbox--steps">
<div class="colorbox__title">
Die goldene Regel:
</div>
Ein System ist genau dann verteilt, wenn der Ausfall eines Computers, von dem du noch nie gehört hast, deine eigene Arbeit unmöglich macht. (Leslie Lamport)
</div>

## Denkpause 💡

Welche Architektur würden sie für
ein Online-Prüfungssystem wählen? Und warum?

(2 Minuten Nachdenken, dann Diskussion)

## Soziotechnische Architektur & Organisation

<div class="colorbox colorbox--hints">
<div class="colorbox__title">
Architektur ist kein Elfenbeinturm 🏛️
</div>
Softwarearchitektur wird oft als rein technisches Puzzle missverstanden. Doch Systeme werden von Menschen in Organisationen gebaut. In diesem Teil untersuchen wir, warum die Art und Weise, wie wir zusammenarbeiten, die Form unserer Software bestimmt.
</div>

<!-- class="lia-callout--note" -->
> **Leitsatz:**🗣️ Wer die Organisation ignoriert, verliert die Kontrolle über die Architektur.

### Architektur-Mythen & Fallstricke

<div class="arrow-list arrows-red">
* **Mythos:** „Das Diagramm ist die Architektur“
{{1}} 
**Realitätscheck:** Dokumentation $\neq$ Struktur. Architektur lebt im Code und in den tatsächlichen Schnittstellen.

* **Mythos:** „Viel hilft viel (Mehr Schichten = besser)“
{{2}}
**Realitätscheck:** Jede Schicht erzeugt Overhead, Komplexität und erhöht die kognitive Belastung für Entwickler.

* **Mythos:** „Performance ist immer das Wichtigste“
{{3}}
**Realitätscheck:** Wartbarkeit, Erweiterbarkeit und Time-to-Market sind oft geschäftskritischer als Millisekunden.

* **Mythos:** „Eine Architektur passt für alle Systeme“
{{4}}
**Realitätscheck:** *No Silver Bullet.* Jedes System benötigt ein individuell ausbalanciertes Trade-off-Profil.

* **Mythos:** „Architektur ist eine rein technische Entscheidung“
{{5}}
**Realitätscheck:** Architektur wird massiv von Budget, Zeitlinien und der Organisationsform beeinflusst.

* **Mythos:** „Unser Programmierer kann das schon irgendwie lösen“
{{6}}
**Realitätscheck:** Ohne Führung entsteht *Accidental Complexity*. Architektur muss aktiv und bewusst gestaltet werden.
</div>


{{7}}
<div>
**Take-away**<!-- class="head" -->

<!-- class="lia-callout--note" -->
> ⚖️ **Architektur ist das Management von Trade-offs.**
> Es ist die bewusste Entscheidung unter Unsicherheit, bei der man heute festlegt, was man morgen nur schwer ändern kann.
</div>

### Conway's Law

> „Organizations which design systems [...] are constrained to produce designs which are copies of the communication structures of these organizations.“ 
> — *Melvin Conway (1967)*

**Die Kernbotschaft:**
Die Struktur der Software spiegelt die Kommunikationswege des Teams wider. Wenn Teams nicht miteinander reden können, werden ihre Software-Module auch nicht sauber integriert sein.

```mermaid @mermaid
graph LR
    subgraph Orga [Organisation / Teams]
        T1[Team Front End] --- T2[Team Back End]
        T2 --- T3[Team Datenbank]
    end

    Orga == "erzeugt zwangsläufig" ==> Arch[Software Architektur]

    subgraph Arch [Software Architektur]
        direction TB
        M1[UI Layer] -.-> M2[API Layer]
        M2 -.-> M3[Data Layer]
    end

    style Orga fill:#E5EDF5,stroke:#004A9A,stroke-width:2px
    style Arch fill:#E5EDF5,stroke:#004A9A,stroke-width:2px
    style T1 fill:#FFF,stroke:#004A9A
    style T2 fill:#FFF,stroke:#004A9A
    style T3 fill:#FFF,stroke:#004A9A
    style M1 fill:#FFF,stroke:#004A9A
    style M2 fill:#FFF,stroke:#004A9A
    style M3 fill:#FFF,stroke:#004A9A
```

### Das Inverse Conway Maneuver

> **„If you want your code to be modular, your teams must be modular.“**

Beim *Inverse Conway Maneuver* nutzt man die Organisation als Werkzeug für das Architekturdesign. Man formt die Kommunikationsstrukturen so, dass die gewünschte Architektur als „Pfad des geringsten Widerstands“ entsteht.

---

**Strategiewechsel**<!-- class="head" -->

| Ansatz | Fokus | Ziel |
| :--- | :--- | :--- |
| **Klassisch** | Bestehende Abteilungen | „Wir bauen, was unsere Struktur zulässt.“ |
| **Invers** | Gewünschte Architektur | „Wir bauen Teams, die diese Architektur erzwingen.“ |

---

**Visualisierung: Struktur folgt Architektur**<!-- class="subhead" -->

```mermaid @mermaid
graph TD
    %% Architektur-Ziel
    subgraph Goal [1. Ziel-Architektur: Microservices]
        direction LR
        S1[Service A] --- S2[Service B] --- S3[Service C]
    end

    Goal == "erfordert" ==> Teams[2. Team-Struktur: Cross-funktional]

    %% Team-Design
    subgraph Teams [2. Team-Struktur: Cross-funktional]
        direction LR
        T1[Team A] --- T2[Team B] --- T3[Team C]
    end

    %% Styles mit Hex-Werten
    style Goal fill:#F5F5F5,stroke:#004A9A,stroke-width:2px,stroke-dasharray: 5 5
    style Teams fill:#E5EDF5,stroke:#004A9A,stroke-width:2px
    style S1 fill:#FFF,stroke:#004A9A
    style S2 fill:#FFF,stroke:#004A9A
    style S3 fill:#FFF,stroke:#004A9A
    style T1 fill:#FFF,stroke:#004A9A,font-weight:bold
    style T2 fill:#FFF,stroke:#004A9A,font-weight:bold
    style T3 fill:#FFF,stroke:#004A9A,font-weight:bold
```

## Technische Resilienz in der Verteilung

<div class="colorbox colorbox--hints">
<div class="colorbox__title">
Die Welt jenseits des Method Call 🌐
</div>
Sobald wir den geschützten Speicherbereich eines einzelnen Prozesses verlassen, ändert sich alles. Ein verteiltes System ist kein "großer Monolith auf mehreren Servern", sondern eine völlig neue Klasse von Herausforderung, bei der Unzuverlässigkeit der Standard ist.
</div>

<!-- class="lia-callout--note" -->
> **Leitsatz:** 🏗️ In einem verteilten System ist „Error Handling“ kein optionales Feature, sondern das eigentliche Design-Fundament.

### Die 8 Fallacies of Distributed Computing

Diese acht Annahmen sind **falsch**, werden aber oft unbewusst bei der Planung verteilter Systeme vorausgesetzt. Wer sie ignoriert, baut instabile Systeme.

<div>

1. **„Das Netzwerk ist zuverlässig“**
{{1}}
*Realität:* Pakete gehen verloren, Switches fallen aus, Kabel werden gezogen. Designen Sie für den Ausfall!

2. **„Die Latenzzeit ist Null“**
{{2}}
*Realität:* Lokale Aufrufe dauern Nanosekunden, Netzwerkaufrufe Millisekunden. Das summiert sich bei vielen Hops.

3. **„Die Bandbreite ist unendlich“**
{{3}}
*Realität:* Auch Gigabit-Leitungen stoßen an Grenzen, besonders bei Microservices-„Geschwätzigkeit“.

4. **„Das Netzwerk ist sicher“**
{{4}}
*Realität:* Gehen Sie davon aus, dass Daten mitgelesen oder manipuliert werden können (*Zero Trust*).

5. **„Die Topologie ändert sich nicht“**
{{5}}
*Realität:* Server kommen und gehen (Cloud!), IP-Adressen wechseln, Router werden neu konfiguriert.

6. **„Es gibt nur einen Administrator“**
{{6}}
*Realität:* Verschiedene Teams verwalten verschiedene Services. Man kann nicht einfach „kurz mal was am Server ändern“.

7. **„Transportkosten sind Null“**
{{7}}
*Realität:* Das Serialisieren von Objekten (JSON/XML) kostet CPU-Zeit und Geld (Cloud-Traffic!).

8. **„Das Netzwerk ist homogen“**
{{8}}
*Realität:* Verschiedene Betriebssysteme, Protokollversionen und Hardware müssen zusammenarbeiten.

</div>

---

**Die Konsequenz: Defensive Architektur**<!-- class="subhead" -->

Um diese Probleme zu lösen, brauchen wir spezifische Muster:

* **Timeouts & Retries:** Warten Sie nicht ewig auf eine Antwort.
* **Circuit Breakers:** Kappen Sie die Verbindung zu einem fehlerhaften Dienst, um Kaskadeneffekte zu vermeiden.
* **Idempotenz:** Stellen Sie sicher, dass mehrfache Aufrufe (bei Retries) keinen Schaden anrichten.

<!-- class="lia-callout--note" -->
> **Das größte Risiko:** Die Annahme, dass sich ein entfernter Service genau so verhält wie ein lokales Objekt im Speicher. Dieser Unterschied ist die Wurzel fast aller Performance- und Stabilitätsprobleme.
### Resilienz-Muster: Circuit Breaker

Wenn ein Service (Fallacy #1) unzuverlässig wird, darf der Aufrufer nicht ewig warten (Fallacy #2). Die Sicherung "springt heraus", um das System zu schützen.

**Die drei Zustände**<!-- class="head" -->

```mermaid @mermaid
stateDiagram-v2
    [*] --> Closed
    
    Closed --> Open : Schwellwert erreicht (Fehlerhäufung)
    note right of Closed : Normalbetrieb - Anfragen gehen durch.
    
    Open --> HalfOpen : Timeout abgelaufen (Wartezeit)
    note left of Open : Fehlerzustand - Anfragen werden sofort abgewiesen (Fail-Fast).
    
    HalfOpen --> Closed : Erfolg (Service stabil)
    HalfOpen --> Open : Fehler (Service noch defekt)
    note right of HalfOpen : Testbetrieb - Wenige Anfragen erlaubt.
```

**Funktionsweise**<!-- class="subhead" -->

    {{1}}
- **Closed** (Geschlossen): Der Normalzustand. Der Circuit Breaker leitet alle Anfragen an den Ziel-Service weiter. Treten Fehler auf, zählt er diese.

    {{2}}
- **Open** (Offen): Wird eine Fehlerschwelle überschritten, öffnet die Sicherung. Alle weiteren Anfragen werden sofort mit einem Fehler beantwortet (Fail-Fast). Das entlastet den überforderten Ziel-Service.

    {{3}}
- **Half-Open** (Halboffen): Nach einer Wartezeit lässt die Sicherung eine begrenzte Anzahl an Test-Anfragen durch. Funktionieren diese, schließt sie sich wieder (Closed). Schlagen sie fehl, geht sie sofort zurück in den Zustand Open.

**Warum ist das wichtig?**<!-- class="subhead" -->

Ohne Circuit Breaker würden bei einem langsamen Service alle Threads des Aufrufers blockiert werden (Warten auf Timeout). Dies führt zum Thread Starvation und bringt letztlich den gesamten Monolithen oder das API-Gateway zum Absturz.

<div class="colorbox colorbox--tips">
<div class="colorbox__title">
Kombination:
</div>
Nutzen Sie Circuit Breaker immer zusammen mit Timeouts. Der Timeout sagt: "Ich warte nicht länger", der Circuit Breaker sagt: "Ich versuche es erst gar nicht, da es sowieso gerade nicht klappt".
</div>

## The end slide

<!-- class="lia-callout--note" style="font-size:huge;" -->
> Vielen Dank für Ihre Aufmerksamkeit!
>
> ![Thank you](https://upload.wikimedia.org/wikipedia/commons/2/25/Thank-you-word-cloud.jpg "Ashashyou, CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0>, via Wikimedia Commons")<!-- style="width:400px;" -->

