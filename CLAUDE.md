# CLAUDE.md — Receptenwebsite

## Over dit project

Een eenvoudige, mooie receptenwebsite gebouwd met Jekyll. Recepten worden opgeslagen als YAML-data in `_data/recepten.yml`, zodat iedereen zonder programmeerkennis recepten kan toevoegen. De site ziet er automatisch goed uit dankzij de basis-CSS.

## Technische keuzes

| Keuze | Waarde |
|---|---|
| Jekyll-versie | 4.x (via Gemfile) |
| Deployment | Klassieke GitHub Pages |
| Contentformaat | YAML in `_data/recepten.yml` |
| Taal | Nederlands |
| CSS | Vanilla CSS (geen frameworks) |

## Contentstructuur

Alle recepten staan in **`_data/recepten.yml`**. Dit is een YAML-bestand waarin elk recept één blok is.

### Verplichte velden per recept

| Veld | Type | Omschrijving |
|---|---|---|
| `naam` | string | De naam van het recept (bijv. "Appeltaart") |
| `categorie` | string | Categorie (bijv. "Gebak", "Pasta", "Soep") |
| `bereidingstijd` | integer | Bereidingstijd in minuten |
| `personen` | integer | Voor hoeveel personen het recept is |
| `ingredienten` | array | Lijst van ingrediënten (regels) |
| `stappen` | array | Stap-voor-stap bereiding |
| `notities` | string (optioneel) | Extra tips of opmerkingen |

### Voorbeeld van een recept

```yaml
- naam: Appeltaart
  categorie: Gebak
  bereidingstijd: 90
  personen: 8
  ingredienten:
    - 300g bloem
    - 200g boter
    - 4 appels
    - 2 eieren
    - 100g suiker
  stappen:
    - Meng bloem en boter tot kruimels.
    - Voeg eieren en suiker toe en kneed tot deeg.
    - Druk in een ingevette vorm.
    - Schil de appels en snijd in stukjes.
    - Verdeel over het deeg.
    - Bak 45 minuten op 180°C tot goudbruin.
  notities: "De taart is het lekkerst als je hem een dag van tevoren maakt."
```

## Projectstructuur

```
recepten/
├── _data/                  # YAML-bestanden met recepten
│   └── recepten.yml
├── _includes/              # Herbruikbare HTML-fragmenten
│   └── nav.html           # Navigatiebalk
├── _layouts/              # Pagina-templates
│   ├── default.html       # Basis-template
│   └── recept.html        # Template voor receptdetailpagina's
├── assets/
│   └── css/
│       └── style.css      # Alle styling
├── _site/                 # Build output (don't edit)
├── _config.yml            # Jekyll configuratie
├── Gemfile                # Ruby dependencies
├── index.md               # Homepagina
└── README.adoc
```

## Plugins en afhankelijkheden

Geen custom plugins. Alleen basis Jekyll met de markdown-verwerker kramdown. Dit houdt het eenvoudig en werkt met klassieke GitHub Pages.

```ruby
# Gemfile
source "https://rubygems.org"
gem "jekyll"
```

## Stijl en opmaak

- **Theme:** Geen extern theme; custom CSS in `assets/css/style.css`
- **Kleur:** Donkerblauw (`#2c3e50`) als primair, rood (`#e74c3c`) als accent
- **Typografie:** Systeemfonts (sneller, geen externe dependencies)
- **Layout:** Recepten tonen als kaarten in een grid (3 kolommen op desktop, 1 op mobiel)

## Afspraken

- **Toevoegen van recepten:** Voeg altijd een volledig blok toe aan `_data/recepten.yml`. Geen velden weglaten; gebruik `null` of een lege string als iets niet van toepassing is.
- **Volgorde:** Recepten verschijnen op de homepagina in de volgorde van `recepten.yml`. Plaats nieuwe recepten bovenaan voor nieuwste-eerst, of onderaan voor stabiele volgorde.
- **Naam uniek:** Zorg dat receptnamen niet identiek zijn; Jekyll gebruikt deze later voor URL's.
- **Geen HTML in YAML:** Inhoud (ingrediënten, stappen, notities) blijft platte tekst. Zelf geen Markdown of HTML toevoegen.

## Klaar om live te gaan?

1. Push naar GitHub: `git add . && git commit -m "Projectstructuur en voorbeeld-recepten" && git push`
2. GitHub Pages instellen:
   - Ga naar Settings → Pages
   - Kies branch: `main` (of `gh-pages` als je die hebt)
   - Deploy
3. Site verschijnt op `https://username.github.io/recepten`
