---
title: Beproefd!!
---

# Beproefd!!

Welkom! Dit is mijn collectie favoriete recepten. Klik op een recept om het volledig recept te zien.

<div class="recepten-grid">
  {% for recept in site.data.recepten %}
    {% assign slug = recept.naam | downcase | replace: " ", "-" | replace: "é", "e" | replace: "è", "e" %}
    <a href="{{ slug | prepend: '/recepten/' | append: '/' | relative_url }}" class="recept-card">
      <h3>{{ recept.naam }}</h3>
      <p>{{ recept.categorie }}</p>
      <span class="categorie">{{ recept.categorie }}</span>
    </a>
  {% endfor %}
</div>