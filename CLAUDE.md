# CLAUDE.md — Receptenwebsite

## Over dit project

Een eenvoudige, mooie receptenwebsite gebouwd met Jekyll. Recepten worden opgeslagen als losse YAML-bestanden in `_data/recepten/`, zodat iedereen zonder programmeerkennis recepten kan toevoegen. De site ziet er automatisch goed uit dankzij de basis-CSS.

## Technische keuzes

| Keuze | Waarde |
|---|---|
| Jekyll-versie | 4.x (via Gemfile) |
| Deployment | GitHub Actions → GitHub Pages |
| Contentformaat | Losse YAML-bestanden in `_data/recepten/` (enige bron) |
| Taal | Nederlands |
| CSS | Vanilla CSS (geen frameworks) |

## Contentstructuur

Alle recepten staan in **`_data/recepten/`** als losse YAML-bestanden. Elk bestand bevat één recept.

### Verplichte velden per recept

| Veld | Type | Omschrijving |
|---|---|---|
| `naam` | string | De naam van het recept (bijv. "Appeltaart") |
| `categorie` | string | Categorie (bijv. "Gebak", "Pasta", "Soep") |
| `bereidingstijd` | integer | Bereidingstijd in minuten |
| `personen` | integer | Voor hoeveel personen het recept is |
| `ingredienten` | array | Lijst van ingrediënten (regels) |
| `stappen` | array | Stap-voor-stap bereiding |
| `tips` | array (optioneel) | Extra tips |
| `tags` | array (optioneel) | Tags voor categorisering |

### Voorbeeld van een recept (`_data/recepten/appeltaart.yml`)

```yaml
naam: Appeltaart
categorie: Gebak
keuken: Nederlands
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
tips:
  - De taart is het lekkerst als je hem een dag van tevoren maakt.
tags:
  - gebak
  - Nederlands
```

## Projectstructuur

```
recepten/
├── _data/                  # YAML-bestanden met recepten
│   ├── categories.yml      # Categorieën
│   └── recepten/           # Losse receptbestanden
│       ├── appeltaart.yml
│       ├── soep.yml
│       └── ...
├── _includes/              # Herbruikbare HTML-fragmenten
│   └── nav.html           # Navigatiebalk
├── _layouts/              # Pagina-templates
│   ├── default.html       # Basis-template
│   ├── recept.html        # Template voor receptdetailpagina's
│   └── categorie.html     # Template voor categoriepagina's
├── assets/
│   └── css/
│       └── style.css      # Alle styling
├── _site/                 # Build output (don't edit)
├── _config.yml            # Jekyll configuratie
├── Gemfile                # Ruby dependencies
├── index.md               # Homepagina
└── README.adoc
```

## Hoe het werkt

1. **Invoer:** Recepten worden ingevoerd als losse YAML-bestanden in `_data/recepten/`.
2. **Build-stap:** Het script `scripts/generate_recipes.rb` leest alle bestanden in `_data/recepten/` en genereert automatisch Markdown-bestanden in `_recepten/` (gegenereerd, niet gecommit).
3. **Jekyll bouw:** Jekyll bouwt de site met homepagina (listing) en detail-pages.
4. **Deployment:** GitHub Actions pusht het gebouwde resultaat automatisch naar GitHub Pages.

**Belangrijk:** Je voegt recepten **altijd toe als een nieuw bestand in `_data/recepten/`** (bijv. `_data/recepten/appeltaart.yml`). De rest gebeurt automatisch bij push.

## Plugins en afhankelijkheden

Geen custom Jekyll-plugins. GitHub Actions voert het Ruby-script uit vóór de Jekyll-build.

```ruby
# Gemfile
source "https://rubygems.org"
gem "jekyll"
```

GitHub Actions workflow: `.github/workflows/jekyll.yml` (geen verdere setup nodig)

## Stijl en opmaak ("Beproefd!!" design)

### Pagina
- **Achtergrondkleur:** Warm crème `#F0EDE4`
- **Geen header/navigatiebalk:** Minimalistisch design

### Titel ("Beproefd!!")
- **Kleur:** Donker navy `#0A2A4A`
- **Lettertype:** Quicksand, Nunito, of Varela Round (sans-serif, afgerond)
- **Gewicht:** 800 (extra bold)
- **Grootte:** 56-64px
- **Uitlijning:** Gecentreerd

### Categorie-kaarten
- **Layout:** CSS Grid, 5 kolommen
- **Gap:** 16px
- **Padding rondom:** 40-60px links/rechts
- **Border-radius:** 12-14px
- **Border:** 1.5px subtiele rand (rgba(0,0,0,0.1))
- **Geen schaduw**

#### Kaartkleuren
| Volgorde | Categorie | Kleur |
|----------|-----------|-------|
| 1 | Voorgerecht | `#3A8B6E` |
| 2 | Soep | `#4DB895` |
| 3 | Hoofdgerecht | `#6EC9A8` |
| 4 | Stoofgerecht | `#1B7A4E` |
| 5 | Ovengerecht | `#2D9E3E` |
| 6 | Pasta en Rijst | `#1A6B4A` |
| 7 | Salades | `#4DB895` |
| 8 | Bijgerecht | `#5AB88E` |
| 9 | Nagerecht | `#3AA87A` |
| 10 | Taart en koekjes | `#7ED8A8` |

### Kaart-tekstualisatie
- **Titel:** Wit `#FFFFFF`, font-weight 600, 16-18px
- **Aantal recepten:** Wit `#FFFFFF` met lichte transparantie, font-weight 400, 14px

### CSS-variabelen (in `:root`)
```css
--bg-page: #F0EDE4;
--text-title: #0A2A4A;
--text-card-heading: #FFFFFF;
--text-card-sub: rgba(255, 255, 255, 0.8);
--font-family: 'Quicksand', 'Nunito', 'Varela Round', sans-serif;
--card-radius: 12px;
--grid-columns: 5;
--grid-gap: 16px;
```

### Files
- **CSS:** `assets/css/style.css` (vanilla CSS, geen frameworks)
- **Categorieën:** `_data/categories.yml` (kleur per categorie)
- **Templates:** `_layouts/categorie.html` voor categoriepagina's

## Afspraken

- **Git commits:** Commit alleen als je daarom vraagt. Maak wijzigingen klaar, vraag "zal ik committen?" en wacht op goedkeuring.
- **Toevoegen van recepten:** Voeg **altijd één nieuw bestand** toe aan `_data/recepten/` (bijv. `_data/recepten/receptnaam.yml`). **Maak NOOIT een verzamelbestand** met meerdere recepten erin. Elk recept krijgt zijn eigen bestand. Zorg dat de bestandsnaam het recept goed beschrijft en uniek is; Jekyll gebruikt deze voor URL-slugs.
- **Inhoud:** Plaats alle veldwaarden in het YAML-bestand. Laat geen velden weg; gebruik `null` of omit het veld als iets niet van toepassing is.
- **Geen HTML in YAML:** Inhoud (ingrediënten, stappen, tips) blijft platte tekst. Zelf geen Markdown of HTML toevoegen.
- **Eén recept per bestand:** Elk YAML-bestand in `_data/recepten/` bevat slechts één recept — nooit meerdere recepten in hetzelfde bestand.

## Klaar om live te gaan?

1. Push naar GitHub: `git push origin main`
2. GitHub Pages instellen:
   - Ga naar Settings → Pages
   - Kies source: "GitHub Actions"
   - Volg de workflow in `.github/workflows/jekyll.yml`
3. Wacht tot de workflow afgerond is (check "Actions" tab)
4. Site verschijnt op `https://username.github.io/recepten`

**Lokaal testen:**
```bash
ruby scripts/generate_recipes.rb  # Genereert _recepten/*.md
bundle exec jekyll serve          # Start dev server op localhost:4000
# Opmerking: lokaal moet je baseurl="" hebben (zie _config.yml)
```
