# Dokumentation #
Denna dokumentation beskriver implementationen av mitt CI/CD-projekt i Kubernetes och omfattar systemets arkitektur, 
teknologier, CI/CD-flödet, API-endpoints och testning samt översikt av Kubernetes-setup.

**1. Arkitekturöversikt** 
Systemet består av:
En webbapplikation (frontend) med Bootstrap och HTML/JavaScript
Ett API i Go (stensax-service)
En MySQL-databas (stensax)
Allt körs i ett Kubernetes-kluster med namespaces, deployment, service och ingress
CI/CD via AWS CodeBuild + GitHub + Docker
Frontend kommunicerar med Go-API:t via /api/play och /api/stats. All speldata sparas i databasen.

**2. CI/CD-processen** 
Koden pushas till mitt privat GitHub-repo
En buildspec.yml triggar AWS CodeBuild
# Bygget:
Kör Go-tester
Bygger en Docker-image
Pushar image till Docker-registret (git.systementor.se)
Kubernetes får en ny version via kubectl rollout restart
# Tools:
GitHub
AWS CodeBuild
Docker
Linodes/Kubernetes

**3. Teknologier** 
API-backend
Go + Gin framework
MySQL
AWS CodeBuild
Docker
Kubernetes
DBeaver
HTML, Bootstrap


**4. API-endpoints + testning** 
GET /api/play?yourSelection=STONE
Returnerar JSON med vem som vann
Testas via webbläsare eller curl
GET /api/stats
Returnerar statistik som: antal spelade matcher, vinster
Testas via browser, curl eller frontend
Testning:
go test -v körs automatiskt i CI
Två enhetstester:
Testar Vinstfall
Testar Oavgjort

**5. Systemarkitektur / Kubernetes** 
Systemet deployas i ett eget Kubernetes-kluster med följande komponenter:
Ingress Controller hanterar routing av inkommande trafik till API och frontend.
stensax Deployment innehåller Go-baserade API:t och servas via en Service.
MySQL-databas är deployad som en separat pod och används av API:t.
Namespace: Allt ligger i my-namespace för isolering.
Service och Deployment-filer används för varje komponent.
Kommunikation sker internt via ClusterIP-tjänster.

Frontend nås via domän https://stensax.home.kg och kommunicerar med API:t via /api/play och /api/stats. CI/CD hanterar kontinuerliga uppdateringar av containrar.
