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

## Stijl en opmaak

- **Theme:** Geen extern theme; custom CSS in `assets/css/style.css`
- **Kleur:** Donkerblauw (`#2c3e50`) als primair, rood (`#e74c3c`) als accent
- **Typografie:** Systeemfonts (sneller, geen externe dependencies)
- **Layout:** Recepten tonen als kaarten in een grid (3 kolommen op desktop, 1 op mobiel)

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
