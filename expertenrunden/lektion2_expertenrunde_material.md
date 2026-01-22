📚 Material für die Expertengruppen
🧩 Gruppe A – Service-orientierte Architektur (SOA)
Grundidee

SOA strukturiert ein System als Sammlung fachlicher Services, die:

klar definierte Schnittstellen haben

über ein Netzwerk kommunizieren

oft von verschiedenen Teams bereitgestellt werden

Services sind größer geschnitten als Microservices.

Zentrale Merkmale

lose Kopplung über Schnittstellen

Fokus auf Geschäftsprozesse

häufig zentrale Steuerung (z. B. Service Registry, Governance)

Vorteile

gute Wiederverwendbarkeit

klare fachliche Struktur

geeignet für große Organisationen

Nachteile

oft schwergewichtig

hoher organisatorischer Aufwand

langsame Weiterentwicklung

Typische Einsatzszenarien

Unternehmenssoftware

Behörden-IT

Integrationsplattformen

Lesematerial

Microservices.io – SOA vs Microservices
https://microservices.io/patterns/soa.html

IBM – Service-Oriented Architecture Overview
https://www.ibm.com/topics/service-oriented-architecture

Wikipedia – Service-oriented architecture
https://en.wikipedia.org/wiki/Service-oriented_architecture

🔧 Gruppe B – Microservices
Grundidee

Microservices zerlegen ein System in sehr kleine, autonome Services, die:

unabhängig deploybar sind

jeweils eine klar abgegrenzte Aufgabe erfüllen

ihre eigenen Daten besitzen

Zentrale Merkmale

dezentrale Datenhaltung

unabhängige Technologieentscheidungen

starke Teamautonomie

Vorteile

hohe Skalierbarkeit

schnelle Weiterentwicklung

gute Fehlerisolation

Nachteile

hohe Komplexität

schwieriges Debugging

verteilte Fehlerbilder

hoher Monitoring-Aufwand

Typische Einsatzszenarien

große Webplattformen

Systeme mit vielen parallelen Nutzern

Organisationen mit vielen Teams

Lesematerial

Martin Fowler: Microservices
https://martinfowler.com/articles/microservices.html

Microservices.io – Microservice Architecture
https://microservices.io/

Atlassian – Microservices Architecture
https://www.atlassian.com/microservices

📡 Gruppe C – Event-Driven Architecture (EDA)
Grundidee

Komponenten kommunizieren nicht direkt, sondern über Events:

ein Service erzeugt ein Event

andere Services reagieren darauf

keine direkte Abhängigkeit zwischen Sender und Empfänger

Zentrale Merkmale

asynchrone Kommunikation

lose Kopplung

hohe Reaktionsfähigkeit

Vorteile

sehr gut skalierbar

flexibel erweiterbar

robust gegenüber Lastspitzen

Nachteile

schwer nachvollziehbarer Kontrollfluss

Debugging komplex

Konsistenz oft nur „eventuell“

Typische Einsatzszenarien

Echtzeitsysteme

Sensornetze

Streaming- & Analyseplattformen

Lesematerial

Martin Fowler: Event-Driven Architecture
https://martinfowler.com/articles/201701-event-driven.html

AWS – What is Event-Driven Architecture
https://aws.amazon.com/event-driven-architecture/

Wikipedia – Event-driven architecture
https://en.wikipedia.org/wiki/Event-driven_architecture
