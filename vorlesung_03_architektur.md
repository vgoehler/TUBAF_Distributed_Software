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

title: Verteilte Software -- Architektur III

tags: Lehre, TUBAF

-->
[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/vgoehler/TUBAF_Distributed_Software/refs/heads/main/vorlesung_03_architektur.md)

# Verteilte Software -- Architektur III

**Distributed Software, 2026**

Volker Göhler, TU Bergakademie Freiberg

------------------------------

![Welcome](https://upload.wikimedia.org/wikipedia/commons/0/02/Fig4b_HPCC.jpg "Fvillanustre, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, via Wikimedia Commons")<!-- style="height:300px;" -->

> "Code" auf https://github.com/vgoehler/TUBAF_Distributed_Software als Open Educational Ressource.

----------------------------------------

## Rückblick

- Was ist Ihnen aus Architektur I und II besonders im Gedächtniss geblieben?
- Wo gab es Verständnisprobleme?
- Welche Fragen sind offen?


## Lernziele

Nach dieser Vorlesung können Sie:

- Qualitätsattribute systematisch bewerten
- Architektur-Trade-offs analysieren
- typische Lösungs- und Fehlmuster erkennen
- Architekturentscheidungen begründen

---

## Teil I – Qualität & Trade-offs

![Quality](https://upload.wikimedia.org/wikipedia/commons/3/37/Long-tailed_macaque_%28Macaca_fascicularis%29_Labuk_Bay.jpg "Charles J. Sharp, CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0>, via Wikimedia Commons")<!-- style="height:500px;" -->

### Qualitätseigenschaften

<!-- style="font-size:25pt; width:auto;" class="lia-callout--note" -->
> Welche Qualitätseigenschaften sind für verteilte Systeme besonders relevant?

### Architektur = Trade-off

<section class="flex-container">
<div class="flex-child">
<div class="colorbox colorbox--info" style="width:auto;">
<div class="colorbox__title">Qualitätsattribute</div>

**Betrieb**

- **Skalierbarkeit:** Lastbewältigung durch Ressourcenzugabe.
- **Verfügbarkeit:** Systemantwort ohne Fehlermeldung.
- **Konsistenz:** Alle Knoten sehen zur gleichen Zeit dieselben Daten.

**Entwicklung**

- Wartbarkeit
- Beobachtbarkeit
- Testbarkeit

**Sonstiges**

- Sicherheit

> ➡ Qualitätsziele stehen oft in Konkurrenz zueinander.

</div>
<div class="colorbox colorbox--warning">
<div class="colorbox__title">
Beispielkonflikte
</div>

- **Starke Konsistenz ↔ Hohe Verfügbarkeit** (CAP)
- **Einfache Architektur ↔ Flexible Erweiterbarkeit**
- **Performance ↔ Fehlertoleranz** (Overhead durch Redundanz)
- **Schnelle Entwicklung ↔ Hohe Wartbarkeit** (VIBE coding)
- **Sicherheit** ↔ **Benutzerfreundlichkeit**

</div>
</div>
<div class="flex-child colorbox colorbox--pros">
<div class="colorbox__title">[CAP-Theorem](https://en.wikipedia.org/wiki/CAP_theorem)</div>

```mermaid @mermaid
graph TD
    C(Consistency) <--> |CA| A(Availability)
    A <--> |AP| P(Partition Tolerance)
    P <--> |CP| C
    
    style C fill:#f9f,stroke:#333,stroke-width:2px
    style A fill:#bbf,stroke:#333,stroke-width:2px
    style P fill:#dfd,stroke:#333,stroke-width:2px
```

**Consistency** (Konsistenz): Jeder Lesevorgang erhält das Ergebnis des letzten Schreibvorgangs (oder einen Fehler).

**Availability** (Verfügbarkeit): Jede Anfrage erhält eine Antwort (keine Garantie, dass es die aktuellsten Daten sind).

**Partition Tolerance** (Partitionstoleranz): Das System arbeitet weiter, auch wenn Nachrichten zwischen Netzwerkknoten verloren gehen oder verzögert werden.

> **Wichtig:** In verteilten Systemen ist Partitionstoleranz (P) meist unverzichtbar. Der reale Trade-off findet daher fast immer zwischen C und A statt.

</div>
</section>

### Fehlertoleranz: "Design for Failure"

<section class="flex-container">
<div class="colorbox colorbox--info flex-child">
<div class="colorbox__title">Strategien & Begriffe</div>

- **Redundanz:** Bereitstellung zusätzlicher Ressourcen (Hardware/Software), die im Normalbetrieb nicht zwingend benötigt werden.
- **Replikation:** Spiegelung von Daten oder Zuständen auf mehrere Knoten, um Datenverlust vorzubeugen.
- **Failover:** Automatisches Umschalten auf ein Backup-System, sobald ein Fehler im Primärsystem erkannt wird.
- **Graceful Degradation:** Die Fähigkeit eines Systems, bei Teilausfällen Kernfunktionen aufrechtzuerhalten (eingeschränkter Betrieb statt Totalausfall).

> ➡ Ziel: **Fehler einplanen**, statt sie krampfhaft vermeiden zu wollen.

</div>

<div class="flex-child colorbox colorbox--pros">
<div class="colorbox__title">Visualisierung: Hochverfügbarkeit</div>



```mermaid @mermaid
flowchart TD
    Client((Client)) --> LB[Load Balancer / Proxy]
    subgraph Cluster [Server Pool]
        LB --> S1[Server A: Aktiv]
        LB -.-> S2[Server B: Standby]
        LB -.-> S3[Server C: Aktiv]
    end
    
    S1 -- Replikation --- S2
    
    style S1 fill:#dfd,stroke:#333
    style S2 fill:#ffd,stroke:#333,stroke-dasharray: 5 5
    style LB fill:#bbf,stroke:#333
```
Mechanismen in der Praxis:

1. **Detection:** Health-Checks prüfen ständig die Vitalität der Server.
2. **Isolation:** Ein fehlerhafter Knoten wird sofort aus dem Verbund entfernt.
3. **Recovery:** Anfragen werden auf gesunde Knoten umgeleitet (Failover).

</div> 
</section>

## Teil II – Architektur-Patterns

<section class="flex-container">
<div class="colorbox colorbox--info flex-child">
<div class="colorbox__title">Was sind Patterns?</div>

> **Wiederkehrende Lösungsstrategien für typische Architekturprobleme.**

Patterns sind keine starren Rezepte, sondern **Orientierungshilfen**, die bewährte Praktiken formalisieren.

</div>

<div class="flex-child">
<div class="colorbox colorbox--pros">
<div class="colorbox__title">
Resilienz-Patterns
</div>

**1. Circuit Breaker (Sicherung)**\
**2. Bulkhead (Schotten)**

</div>

<div class="colorbox colorbox--pros">
<div class="colorbox__title">Stabilität & Performance</div>

**3. Retry mit Backoff**\
**4. Caching & Read Replicas**

</div>
<div class="colorbox colorbox--pros">
<div class="colorbox__title">Daten & Skalierung</div>

**5. Read Replicas**\
**6. Saga**

</div>
</div>
</section>

### Resilienz-Patterns

![](https://upload.wikimedia.org/wikipedia/commons/7/75/Electronic-Axial-Lead-Resistors-Array.jpg "Evan-Amos, Public domain, via Wikimedia Commons")<!-- style="height:400px;" -->

#### Pattern: Circuit Breaker

> siehe auch Architektur I Vorlesung

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Pattern: Circuit Breaker</div>

**Konzept:** Eine "Sicherung", die bei zu vielen Fehlern die Verbindung zum Zielsystem kappt, um Ressourcen zu schonen.

- **Ziel:** Kaskadierende Fehler verhindern.
- **Zustände:** Geschlossen (OK), Offen (Fehler), Halboffen (Testlauf).

</div>
<div class="flex-child colorbox colorbox--pros">

```mermaid @mermaid
graph TD
    %% Definition der Zustände
    C(Closed: Normalbetrieb):::success
    O(Open: Fehlerzustand):::danger
    HO(Half-Open: Testphase):::warning

    %% Übergänge
    C -->|Schwellwert erreicht| O
    O -->|Timeout abgelaufen| HO
    HO -->|Erfolg| C
    HO -->|Fehler| O

    %% Styles
    classDef success fill:#D4EDDA,stroke:#155724,stroke-width:2px;
    classDef danger fill:#F8D7DA,stroke:#721C24,stroke-width:2px;
    classDef warning fill:#FFF3CD,stroke:#856404,stroke-width:2px;
```

</div>
</section>

<!-- class="lia-callout--question" -->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?

#### Pattern: Bulkhead

<section class="flex-container"> 
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Pattern: Bulkhead</div>

**Konzept:** Aufteilung von Ressourcen (z. B. Thread-Pools) in isolierte Bereiche. (Schotten im Schiffsbau)

- **Ziel:** Fehlercontainment.
- **Vorteil:** Wenn ein Pool (z. B. Suche) überlastet ist, bleibt der Rest (z. B. Checkout) funktionsfähig.

</div>
<div class="flex-child colorbox colorbox--pros">

```mermaid @mermaid
graph TD
    LB[Load Balancer]:::primary --> P1[Pool A: Payment]:::danger
    LB --> P2[Pool B: Search]:::success
    
    P1 --- X((X)):::danger
    
    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef success fill:#D4EDDA,stroke:#155724;
    classDef danger fill:#F8D7DA,stroke:#721C24;
```
</div>
</section>

<!-- class="lia-callout--question" -->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?

### Stabilitäts & Performance-Patterns

![](https://upload.wikimedia.org/wikipedia/commons/4/49/San_Francisco_%28CA%2C_USA%29%2C_Golden_Gate_Bridge_--_2022_--_3023_%28bw%29.jpg "Dietmar Rabich / Wikimedia Commons / “San Francisco (CA, USA), Golden Gate Bridge -- 2022 -- 3023 (bw)” / CC BY-SA 4.0For print products: Dietmar Rabich / https://commons.wikimedia.org/wiki/File:San_Francisco_(CA,_USA),_Golden_Gate_Bridge_--_2022_--_3023_(bw).jpg")<!-- style="height:400px;" -->

#### Pattern: Retry mit Backoff

<section class="flex-container">
<div class="flex-child">
<div class="colorbox colorbox--info" style="width:auto;">
<div class="colorbox__title">Pattern: Retry mit Backoff</div>

**Konzept:** Automatisches Wiederholen fehlgeschlagener Operationen.

- **Exponential Backoff:** Die Wartezeit verdoppelt sich nach jedem Versuch.
- **Wichtig:** Nur bei transienten (vorübergehenden) Fehlern sinnvoll.

</div>

<!-- class="lia-callout--question" style="width:auto;"-->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?

</div>

<div class="flex-child colorbox colorbox--pros">

```mermaid @mermaid
sequenceDiagram
    autonumber
    participant C as Client
    participant S as Service
    
    Note over C,S: Start mit Exponential Backoff
    C->>S: Request
    S-->>C: 503 Error
    Note left of C: Wait 1s
    C->>S: Retry 1
    S-->>C: 503 Error
    Note left of C: Wait 2s
    C->>S: Retry 2
    S-->>C: 200 OK
```

</div>
</section>


#### Pattern: Sidecar

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Pattern: Sidecar</div>

**Konzept:** Ein Hilfscontainer wird neben die Hauptanwendung gestellt, um Infrastruktur-Aufgaben zu übernehmen.

- **Aufgaben:** Logging, Monitoring, Retry-Logik, Security (mTLS).
- **Vorteil:** Die Applikationslogik bleibt sauber.

</div>

<div class="flex-child colorbox colorbox--pros">
```mermaid @mermaid
graph LR
    subgraph Pod [Kubernetes Pod / Instanz]
        direction LR
        App[Order-Service<br/>Python/Java]:::success
        SC[Envoy Proxy<br/>Sidecar]:::primary
        
        App <-->|Localhost| SC
    end
    
    SC <-->|TLS / Auth| Net((Externes<br/>Netzwerk)):::storage
    SC -.->|Metrics| Mon[Prometheus]:::warning

    classDef primary fill:#CCE5FF,stroke:#004085,stroke-width:2px;
    classDef success fill:#D4EDDA,stroke:#155724,stroke-width:2px;
    classDef storage fill:#E2E3E5,stroke:#383D41,stroke-width:2px;
    classDef warning fill:#FFF3CD,stroke:#856404,stroke-width:2px;
```
</div>
</section>

<!-- class="lia-callout--question" -->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?

### Daten & Skalierung

![](https://upload.wikimedia.org/wikipedia/commons/4/40/Commander_Data_-_Star_Trek_-_The_Next_Generation_-_Star_Trek-_Exploring_New_Worlds_Exhibit_at_the_Henry_Ford_Museum%2C_Dearborn%2C_Michigan.jpg "Joe Ross, CC BY-SA 2.0 <https://creativecommons.org/licenses/by-sa/2.0>, via Wikimedia Commons")<!-- style="height:400px;" -->

#### Pattern: Read Replicas

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Pattern: Read Replicas</div>

**Konzept:** Trennung von Schreib- (Primary) und Lesezugriffen (Replicas).

- **Vorteil:** Massive Skalierung der Leselast.
- **Trade-off:** Eventual Consistency (Daten auf Replicas hinken evtl. kurz hinterher).

</div>
<div class="flex-child colorbox colorbox--pros">

```mermaid @mermaid
graph TD
    App[Application]:::primary -->|Write| P[(Primary)]:::storage
    P -->|Replication| R1[(Replica)]:::storage
    P -->|Replication| R2[(Replica)]:::storage
    App -.->|Read| R1
    App -.->|Read| R2

    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef storage fill:#E2E3E5,stroke:#383D41;
```
</div>
</section>

<!-- class="lia-callout--question" -->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?

#### Pattern: Saga

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Pattern: Saga</div>
**Problem:** In Microservices gibt es keine "globale Datenbank-Transaktion".\
**Lösung:** Eine Saga führt eine Kette von lokalen Transaktionen aus.

* **Success:** Jeder Service schließt seine Aufgabe ab.
* **Failure:** Tritt ein Fehler auf, müssen alle vorherigen erfolgreichen Schritte durch **Kompensation** rückgängig gemacht werden (z. B. Storno).

> ➡ Ersetzt klassisches 2-Phase-Commit (2PC) in verteilten Systemen.

</div>
<div class="flex-child colorbox colorbox--pros">
```mermaid @mermaid
graph TD
    subgraph Saga_Workflow [Saga: Bestellung]
        direction TB
        
        subgraph S1 [Order Service]
            direction LR
            O_Apply[1. Bestellung erstellen]:::success
            O_Undo[5. Bestellung stornieren]:::warning
        end

        subgraph S2 [Payment Service]
            direction LR
            P_Apply[2. Zahlung abbuchen]:::success
            P_Undo[4. Zahlung erstatten]:::warning
        end

        subgraph S3 [Stock Service]
            direction LR
            S_Apply[3. Lager prüfen]:::danger
        end

        %% Happy Path
        O_Apply --> P_Apply
        P_Apply --> S_Apply
        
        %% Failure & Compensation Path
        S_Apply -- "Fehler: Out of Stock" --> P_Undo
        P_Undo --> O_Undo
    end

    classDef success fill:#D4EDDA,stroke:#155724,stroke-width:2px;
    classDef danger fill:#F8D7DA,stroke:#721C24,stroke-width:2px;
    classDef warning fill:#FFF3CD,stroke:#856404,stroke-width:2px;

    %% Style für den äußeren Subgraph (Light Blue)
    style Saga_Workflow fill:#E1F5FE,stroke:#01579B,stroke-dasharray: 5 5
```
</div>
</section>

<!-- class="lia-callout--question" -->
> Wo könnte dieses Pattern in verteilten Systemen nützlich sein?


## Teil III – Anti-Patterns

![](https://upload.wikimedia.org/wikipedia/commons/1/19/Train_wreck_at_Montparnasse_1895.jpg "Photo credited to the firm Levy & fils by this site. Public domain, via Wikimedia Commons")<!-- style="height:400px;" -->

### Was sind Anti-Patterns?

<!-- class="lia-callout--note" style="width:auto;"-->
> **Häufige Fehlentwicklungen, die zunächst als Lösung erscheinen, aber langfristig hohen Schaden anrichten.**

Sie entstehen meist durch:

- Zeitdruck ("Quick & Dirty"), 
- fehlendes Domänenverständnis oder 
- technische Altlasten (technical debt).

### Anti-Pattern: Distributed Monolith

<section class="flex-container">
<div class="flex-child colorbox colorbox--steps">
<div class="colorbox__title">
Anti-Pattern: Distributed Monolith
</div>
* **Problem:** Viele Services, die aber nur gemeinsam deployt werden können.
* **Symptom:** Eine Änderung in Service A erfordert zwingend Änderungen in B, C und D.
* **Folge:** Man hat die Komplexität von Microservices (Netzwerk-Overhead), aber die Unflexibilität eines Monolithen.

</div>
<div class="flex-child colorbox colorbox--cons">

```mermaid @mermaid
graph TD
    subgraph Deployment_Unit [Zwangskoppelung]
        S1[Service A]:::danger <--> S2[Service B]:::danger
        S2 <--> S3[Service C]:::danger
        S3 <--> S1
    end
    
    classDef danger fill:#F8D7DA,stroke:#721C24,stroke-width:2px;
```
</div>
</section>

### Anti-Pattern: Shared Database

<section class="flex-container"> 
<div class="flex-child colorbox colorbox--steps">
<div class="colorbox__title">Anti-Pattern: Shared Database</div>

- **Problem:** Mehrere Services teilen sich ein Datenbankschema.

- **Gefahr:** Ein Service ändert eine Spalte und bricht damit die Logik von drei anderen Services.

- **Besser:** Database per Service -> Zugriff nur über APIs.

</div>
<div class="flex-child colorbox colorbox--cons">

```mermaid @mermaid
graph TD
    S1[Order Service]:::primary
    S2[User Service]:::primary
    S3[Billing Service]:::primary
    
    S1 & S2 & S3 --> DB[(Shared DB)]:::danger
    
    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef danger fill:#F8D7DA,stroke:#721C24,stroke-width:2px;
```
</div>
</section>

### Anti-Pattern: God Service / Brain Service

<section class="flex-container">
<div class="flex-child colorbox colorbox--steps">
<div class="colorbox__title">Anti-Pattern: God Service / Brain Service</div>

- **Problem:** Ein Service übernimmt die gesamte Geschäftslogik; andere Services sind nur "dumme Datenspeicher".
- **Folge:** Single Point of Failure, massive Performance-Bottlenecks und schwerfällige Entwicklung.

</div>
<div class="flex-child colorbox colorbox--cons">
```mermaid @mermaid
graph TD
    GS(GOD SERVICE):::danger
    S1[Helper A]:::storage
    S2[Helper B]:::storage
    S3[Helper C]:::storage
    
    GS --> S1 & S2 & S3
    
    classDef danger fill:#F8D7DA,stroke:#721C24,stroke-width:4px;
    classDef storage fill:#E2E3E5,stroke:#383D41;
```
</div>
</section>

### Anti-Pattern: Event Spaghetti

<section class="flex-container">
<div class="flex-child colorbox colorbox--steps">
<div class="colorbox__title">Anti-Pattern: Event Spaghetti</div>

- **Problem:** Unübersichtliche Ketten von Events ("A feuert Event, das B triggert, das C triggert, das wiederum A triggert").

- **Folge:** Niemand versteht mehr den Gesamtablauf; Debugging wird zum Albtraum.

</div>
<div class="flex-child colorbox colorbox--cons">

```mermaid @mermaid
graph LR
    A[S_A]:::warning -- e1 --> B[S_B]:::warning
    B -- e2 --> C[S_C]:::warning
    C -- e3 --> A
    B -- e4 --> D[S_D]:::warning
    D -- e5 --> B
    
    classDef warning fill:#FFF3CD,stroke:#856404;
```
</div>
</section>

### Diskussionsfrage

<!-- class="lia-callout--question" -->
> Warum entstehen diese Anti-Patterns immer wieder?

## Teil IV – Architektur & Organisation

![](https://upload.wikimedia.org/wikipedia/commons/2/23/Conways%2C_Blackrock.JPG "DubhEire, CC0, via Wikimedia Commons")<!-- style="height:400px;" -->

### Conway’s Law

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Conway’s Law</div>

> **"Organisationen, die Systeme entwerfen, sind gezwungen, Entwürfe zu erstellen, die die Kommunikationsstrukturen dieser Organisationen kopieren."**

* **Silos:** Getrennte Abteilungen (Frontend, Backend, DB) führen oft zu schichtbasierten Monolithen.
* **Autonome Teams:** Cross-funktionale Teams fördern modulare Microservices.
* **Chaos:** Unklare Zuständigkeiten führen zu "Spaghetti-Architektur".

*Rückblick auf Vorlesung I*

</div>
<div class="flex-child colorbox colorbox--pros">
```mermaid @mermaid
graph TD
    subgraph Org [Organisation]
        T1[Team A]:::primary --- T2[Team B]:::primary
    end
    
    subgraph Sys [System-Architektur]
        M1[Modul A]:::success <--> M2[Modul B]:::success
    end
    
    Org -.->|spiegelt sich in| Sys
    
    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef success fill:#D4EDDA,stroke:#155724;
```
</div>
</section>

### Architektur für Betrieb & Teamarbeit

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Betrieb & Teamarbeit</div>

Architektur ist kein Elfenbeinturm. Viele Systeme scheitern nicht am Design, sondern am mangelnden Fokus auf den Betrieb ("Day 2 Operations").

- **Monitoring & Observability:** Wissen, was das System tut.
- **Incident Management:** Reagieren, wenn es brennt.
- **Deployment:** Automatisierung (CI/CD) statt manueller Angst-Releases.

> ➡ Architektur umfasst technische, organisatorische und kommunikative Entscheidungen.

</div>
<div class="flex-child colorbox colorbox--pros">
```mermaid @mermaid
mindmap
  root((Architektur))
    Technik
      Patterns
      Code-Design
    Organisation
      Team-Schnittstellen
      Conway
    Betrieb
      Monitoring
      Deployment
```
</div>
</section>

## Teil V – Entscheidungen treffen

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Entscheidungen explizit machen</div>

Gute Entscheidungen basieren auf Fakten, nicht auf Hypes. Sie müssen folgende Kriterien erfüllen:

- **Kontextabhängig:** Passt es zu unserem Problem?
- **Dokumentiert:** Warum haben wir uns so entschieden? (z.B. via Architecture Decision Records ([ADR](https://github.com/joelparkerhenderson/architecture-decision-record)))
- **Revidierbar:** Können wir die Entscheidung korrigieren, wenn sich Annahmen ändern?

**Anti-Muster:**

- "Weil es modern ist" (Hype-driven Development)
- "Weil es alle so machen" (Cargo-Cult)
- "Weil der Chef es will" (Autoritätsargument)
- "Weil es in der Schulung so war" (Schulungsgetrieben)
- "Weil es schnell geht" (Short-term Thinking)
- "Weil wir es schon immer so gemacht haben" (Status Quo Bias)

</div>
<div class="flex-child colorbox colorbox--pros">
```mermaid @mermaid
graph TD
    Z[Ziele]:::primary --> E{Entscheidung}
    R[Risiken]:::danger --> E
    A[Alternativen]:::success --> E
    K[Kosten]:::warning --> E
    A1[Annahmen]:::storage --> E
    
    E --> Doc[ADR Dokumentation]:::storage

    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef success fill:#D4EDDA,stroke:#155724;
    classDef danger fill:#F8D7DA,stroke:#721C24;
    classDef warning fill:#FFF3CD,stroke:#856404;
    classDef storage fill:#E2E3E5,stroke:#383D41;
```
</div>
</section>

## Teil VI – Fallstudie: Architektur-Workshop

![](https://upload.wikimedia.org/wikipedia/commons/a/a7/UNICEF_DSC03709_%2821074874624%29.jpg "UNICEF Ukraine from Kyiv, Ukraine, CC BY 2.0 <https://creativecommons.org/licenses/by/2.0>, via Wikimedia Commons")<!-- style="height:400px;" -->

### Das Szenario: "Campus-Connect"

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">Das Szenario: "Campus-Connect"</div>

**Ein modernes Studierenden-Management-System für:**

* **Live-Interaktion:** Vorlesungen & Echtzeit-Chat.
* **Prüfungsbetrieb:** Notenverwaltung & Online-Prüfungen.
* **Content:** Asynchrone Inhalte (Video/Files) & AI-Lernhelfer.

---

**Die Eckdaten (Constraints):**

- **User:** 2.000 Studierende / 100 Lehrende.
- **Lastspitzen:** Extrem hoch während Prüfungsphasen.
- **Compliance:** Höchste Anforderungen an Datenschutz & Sicherheit.

</div>
<div class="flex-child colorbox colorbox--pros">

```mermaid @mermaid
graph TD
    S(Student):::primary
    L(Lehrender):::primary
    
    subgraph System [Campus-Connect]
        C1[Live & Chat]:::warning
        C2[Prüfung & Noten]:::danger
        C3[Content & AI]:::success
    end
    
    S & L --> System

    classDef primary fill:#CCE5FF,stroke:#004085;
    classDef success fill:#D4EDDA,stroke:#155724;
    classDef danger fill:#F8D7DA,stroke:#721C24;
    classDef warning fill:#FFF3CD,stroke:#856404;
```
</div>
</section>

### Navigationshilfe: Architektur-Stile

<div class="colorbox colorbox--info" style="width:auto;">
<div class="colorbox__title">Strukturierter Entscheidungsprozess (Attribute-Driven Design (ADD))</div>

Gute Architektur entsteht nicht durch "Hype", sondern durch die Priorisierung von **Architectural Drivers** (Qualitätsattributen).

1.  **Szenarien definieren:** "Was passiert bei 2000 gleichzeitigen Logins?"
2.  **Attribute gewichten:** Ist uns *Verfügbarkeit* wichtiger als *Konsistenz*? (CAP-Trade-off)
3.  **Stil wählen:** Welcher Stil unterstützt unsere Top-Prioritäten nativ?

> **Quelle:** Inspiriert durch das [*Attribute-Driven Design (ADD)* Framework](https://www.sei.cmu.edu/library/attribute-driven-design-add-version-20/) des Software Engineering Institute (SEI).

</div>

<!-- class="head" -->
**Vergleichs-Matrix für die Fallstudie**

Nutzen Sie diese Matrix, um Ihre Wahl in der Gruppenarbeit zu begründen:
Diese sind aber nicht in Stein gemeißelt – es gibt viele Variationen und Hybrid-Ansätze.

| Architekturstil | Fokus (QA) | Bekannte Trade-offs | Beispiel in der Fallstudie |
| --- | --- | --- | --- |
| 3-Tier | Konsistenz (C) | Schwer horizontal skalierbar | Notenverwaltung |
| Microservices | Skalierbarkeit (P) | Hohe operative Komplexität | AI-Lernhelfer |
| Event-Driven | Performance (A) | Eventual Consistency | Live-Chat / Benachrichtigung |
| SOA | Integration | Latenz durch Enterprise Service Bus | Anbindung Altsystem (Verwaltung) |


<div class="colorbox colorbox--steps" style="width:auto;">
<div class="colorbox__title">
Architekten-Tipp:
</div>

"Everything in software architecture is a trade-off."

Es ist völlig legitim, für verschiedene Module der Fallstudie verschiedene Stile zu wählen (Hybrid-Architektur).
</div>

### Arbeitsauftrag: Design & Diskurs

<section class="flex-container">
<div class="flex-child colorbox colorbox--info">
<div class="colorbox__title">👨‍👩‍👧‍👦 Gruppenarbeit (3-4 Pers.)</div>

**Entwerfen Sie eine tragfähige Architektur und klären Sie:**

1. **Architekturstil:** Monolith, Microservices oder Serverless? Oder was anderes?
2. **Kommunikation:** Synchron (REST/gRPC) vs. Asynchron (Events)?
3. **Daten:** Shared Database oder Database-per-Service?
4. **Resilienz:** Welche Patterns (Circuit Breaker, Bulkheads) schützen die Notenverwaltung? Wo brauchen wir noch Resilienz?

**Kernfrage:** Wie gehen Sie mit dem CAP-Theorem um, wenn das Netz während einer Prüfung instabil ist?

</div>
<div class="flex-child colorbox colorbox--pros">
<div class="colorbox__title">⚖️ Trade-off Analyse</div>

**Kein Design ohne Opfer.** Diskutieren Sie bewusst:

- Was opfern Sie zugunsten der Sicherheit?
- Wo akzeptieren Sie Eventual Consistency?
- Was ist wichtiger: Schnelle Antwortzeiten im Chat oder 100% Datenintegrität bei den Noten?

**Präsentation (3 Min):**

- Fokus: Warum haben Sie sich so entschieden?
- Es gibt keine perfekte Lösung, nur begründete Entscheidungen.

</div>
</section>

## Teil VII – Abschluss

<section class="flex-container">
<div class="colorbox colorbox--steps flex-child">
<div class="colorbox__title">
Typische Fehler und Fallstricke
</div>

- Over-Engineering
- Technik ohne Kontext
- Ignorieren der Organisation
- fehlende Dokumentation

</div>

<div class="colorbox colorbox--danger flex-child">
<div class="colorbox__title">
Zentrale Erkenntnis
</div>

> Architektur ist keine Optimierung, sondern eine verantwortete Entscheidung.

</div>
</section>

<section class="flex-container">
<div class="flex-child" style="width:auto;">

<!-- class="head" -->
Abschluss

<!-- class="lia-callout--note" style="width:auto;" -->
> Jede Architektur kauft Vorteile mit neuen Problemen.
>
> Gute Entscheidungen erkennen diesen Tausch und treffen ihn bewusst.

</div>

<div class="flex-child">
![Thank You](https://upload.wikimedia.org/wikipedia/commons/e/ea/Ray_and_Maria_Stata_Center_%28MIT%29.JPG "Lucy Li, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, via Wikimedia Commons")<!-- style="height:400px;" -->
</div>
</section>
