# Jekyll Site Generator — Werkwijze

Dit project volgt een vaste aanpak voor het bouwen van Jekyll-websites waarbij **content en opmaak strikt gescheiden** zijn. Volg de stappen hieronder elke keer als een nieuwe site gebouwd wordt.

---

## Stap 1 — Bepaal het onderwerp

Vraag de gebruiker altijd eerst:

> "Waarvoor is deze site bedoeld? Bijvoorbeeld: recepten, reizen, boeken, films, planten, foto's, ..."

Pas op basis van het antwoord de structuur, dataformaten en voorbeelden aan.

---

## Stap 2 — Kies een dataformaat

Stel de gebruiker een aantal opties voor, afgestemd op het onderwerp. Leg de voor- en nadelen uit en geef concrete voorbeelden.

### Beschikbare opties

#### YAML (in `_data/`)
Geschikt voor gestructureerde, relatief compacte data. Leesbaar, geen programmeerkennis nodig.

**Voorbeeld voor recepten (`_data/recepten.yml`):**
```yaml
- naam: Appeltaart
  categorie: Gebak
  bereidingstijd: 90
  ingredienten:
    - 300g bloem
    - 200g boter
    - 4 appels
  stappen:
    - Meng bloem en boter.
    - Schil de appels en snijd ze in stukjes.
```

**Voorbeeld voor boeken (`_data/boeken.yml`):**
```yaml
- titel: De Ontdekking van de Hemel
  auteur: Harry Mulisch
  jaar: 1992
  genre: Roman
  gelezen: true
  beoordeling: 5
```

**Voorbeeld voor reizen (`_data/reizen.yml`):**
```yaml
- bestemming: Kyoto
  land: Japan
  jaar: 2023
  highlights:
    - Arashiyama bamboebos
    - Fushimi Inari schrijn
  foto_map: /assets/fotos/kyoto
```

---

#### Markdown met Front Matter (in `_posts/` of een collectie)
Geschikt als elk item ook een langere tekst of verhaal bevat. De metadata staat bovenaan (front matter), de tekst eronder.

**Voorbeeld voor een recept (`_recepten/appeltaart.md`):**
```markdown
---
naam: Appeltaart
categorie: Gebak
bereidingstijd: 90
ingredienten:
  - 300g bloem
  - 200g boter
  - 4 appels
---

Dit is mijn grootmoeders recept, overgeleverd van generatie op generatie.
Gebruik bij voorkeur zure appels zoals Elstar of Goudrenet.
```

---

#### JSON (in `_data/`)
Zelfde functie als YAML, maar handig als de data al van elders (API, export) komt in JSON-formaat. Minder leesbaar voor handmatige bewerking.

**Voorbeeld (`_data/recepten.json`):**
```json
[
  {
    "naam": "Appeltaart",
    "categorie": "Gebak",
    "bereidingstijd": 90,
    "ingredienten": ["300g bloem", "200g boter", "4 appels"]
  }
]
```

---

#### AsciiDoc met Front Matter (alleen bij GitHub Actions)
Via de plugin `jekyll-asciidoc` verwerkt Jekyll `.adoc`-bestanden met Asciidoctor. Krachtiger dan Markdown, met o.a. native cross-references, includes en admonitions. **Niet beschikbaar bij klassieke GitHub Pages** (plugin staat niet op de whitelist).

**Voorbeeld voor een recept (`_recepten/appeltaart.adoc`):**
```asciidoc
---
naam: Appeltaart
categorie: Gebak
bereidingstijd: 90
---

= Appeltaart

Dit is mijn grootmoeders recept, overgeleverd van generatie op generatie.
Gebruik bij voorkeur zure appels zoals Elstar of Goudrenet.

NOTE: De taart is het lekkerst als je hem een dag van tevoren maakt.

== Ingrediënten

* 300g bloem
* 200g boter
* 4 appels

== Bereiding

. Meng bloem en boter.
. Schil de appels en snijd ze in stukjes.
```

Voeg aan `Gemfile` toe:
```ruby
gem "jekyll-asciidoc"
```

En aan `_config.yml`:
```yaml
plugins:
  - jekyll-asciidoc
```

---

### Vuistregel voor keuze

| Situatie | Aanbevolen formaat | Vereist Actions? |
|---|---|---|
| Korte, gestructureerde items zonder veel tekst | YAML in `_data/` | Nee |
| Items met een langere beschrijving of verhaal | Markdown met front matter | Nee |
| Data afkomstig van een export of API | JSON in `_data/` | Nee |
| Combinatie van gestructureerd + vrije tekst | Markdown collectie | Nee |
| Rijke opmaak, cross-references, includes | AsciiDoc met front matter | Ja |

---

## Stap 3 — GitHub Pages: klassiek of via Actions?

Vraag de gebruiker:

> "Komt de site op GitHub Pages te staan?"

Als ja, vraag dan:

> "Gebruik je klassieke GitHub Pages (branch `gh-pages` of `main`/`docs`), of wil je GitHub Actions gebruiken voor meer controle?"

### Verschil uitgelegd

#### Klassieke GitHub Pages
- Jekyll wordt automatisch door GitHub gebouwd.
- Je bent beperkt tot de [door GitHub ondersteunde plugins en Jekyll-versie](https://pages.github.com/versions/).
- Eenvoudig te configureren: geen workflow-bestanden nodig.
- **Beperking:** Alleen whitelisted plugins, momenteel Jekyll 3.10.x.

#### GitHub Actions (aanbevolen voor meer vrijheid)
- Je bouwt Jekyll zelf in een workflow, GitHub Pages host alleen het resultaat.
- Ondersteunt **elke Jekyll-versie** (bijv. Jekyll 4.x) en **alle plugins**.
- Iets meer configuratie nodig (`.github/workflows/jekyll.yml`).
- **Aanbevolen** als je moderne themes, Liquid-filters of plugins wilt gebruiken.

Houd bij de inrichting van het project rekening met de gekozen optie:
- Klassiek: `Gemfile` met alleen whitelisted gems; geen onondersteunde plugins.
- Actions: vrijere keuze, voeg een workflow-bestand toe.

---

## Stap 4 — Projectstructuur opzetten

Zorg altijd voor een strikte scheiding van **content** en **opmaak**:

```
├── _data/              # Ruwe data (YAML/JSON) — alleen content, geen HTML
├── _includes/          # Herbruikbare HTML-fragmenten (navigatie, kaarten, etc.)
├── _layouts/           # Pagina-templates (default, post, recept, etc.)
├── _sass/ of assets/   # Stijlen (CSS/SCSS) — alleen opmaak, geen content
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
├── _config.yml         # Jekyll configuratie
├── Gemfile             # Ruby dependencies
├── index.md            # Startpagina
└── [collecties/]       # Optioneel: _recepten/, _posts/, etc.
```

**Principe:** Niemand hoeft een layout-bestand aan te passen om een nieuw item toe te voegen. Data gaat in `_data/` of als Markdown-bestand; de templates pakken dat automatisch op.

---

## Algemene afspraken

- Geen hardcoded content in layout-bestanden.
- Gebruik `site.data.*` of collecties om content te ontsluiten.
- Houd `_config.yml` leesbaar en goed gedocumenteerd.
- Gebruik betekenisvolle variabelenamen in front matter en YAML, in het Nederlands als de site Nederlandstalig is.

---

## Stap 5 — Genereer een project-specifieke CLAUDE.md

Genereer aan het einde van het intakegesprek (stappen 1–3) een voorstel voor een `CLAUDE.md` die bij de nieuw te bouwen site hoort. Sla dit voorstel op als **`CLAUDE-NEW.md`** zodat de gebruiker het kan beoordelen voordat het de huidige `CLAUDE.md` overschrijft. Vraag na het aanmaken expliciet of de inhoud akkoord is, en pas aan waar nodig. Hernoem het bestand pas naar `CLAUDE.md` als de gebruiker goedkeuring geeft.

Deze projectspecifieke `CLAUDE.md` vervangt de algemene werkwijze en beschrijft de concrete afspraken voor dát project.

Gebruik daarvoor de volgende template, ingevuld op basis van de antwoorden van de gebruiker:

```markdown
# CLAUDE.md — [Naam van de site]

## Over dit project

[Korte beschrijving van de site: onderwerp, doelgroep, doel.]

## Technische keuzes

| Keuze | Waarde |
|---|---|
| Jekyll-versie | [bijv. 4.3] |
| Deployment | [Klassieke GitHub Pages / GitHub Actions] |
| Contentformaat | [YAML / Markdown / AsciiDoc / JSON] |
| Taal | [Nederlands / Engels / ...] |

## Contentstructuur

[Beschrijf waar de content staat en hoe een nieuw item toegevoegd wordt.]

Bijvoorbeeld:
- Nieuwe items gaan in `_data/[onderwerp].yml` als YAML-blok.
- Of: Nieuwe items zijn `.md`-bestanden in `_[collectie]/`.
- Of: Nieuwe items zijn `.adoc`-bestanden in `_[collectie]/`.

### Verplichte velden per item

| Veld | Type | Omschrijving |
|---|---|---|
| [veld1] | string | [uitleg] |
| [veld2] | integer | [uitleg] |
| ... | ... | ... |

### Voorbeeld van een item

[Voeg hier een minimaal, volledig voorbeeld in van een correct item in het gekozen formaat.]

## Projectstructuur

[Geef de mappenstructuur weer zoals die voor dit project geldt, inclusief eventuele collecties.]

## Plugins en afhankelijkheden

[Lijst van gebruikte gems/plugins met korte toelichting. Vermeld expliciet of er niet-whitelisted plugins worden gebruikt en waarom GitHub Actions dan vereist is.]

## Stijl en opmaak

[Beschrijf het gekozen theme of CSS-framework, en eventuele afspraken over kleur, typografie of layout.]

## Afspraken

- [Projectspecifieke afspraak 1]
- [Projectspecifieke afspraak 2]
- ...
```

Pas de template aan op het onderwerp: laat irrelevante secties weg, voeg specifieke velden toe, en zorg dat het voorbeeld aansluit bij de daadwerkelijke content van de site.
