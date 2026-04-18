---
title: Recepten
---

# Recepten

Welkom! Dit is mijn collectie favoriete recepten. Klik op een recept om het volledig recept te zien.

<div class="recepten-grid">
  {% for recept in site.data.recepten %}
    <a href="#" class="recept-card">
      <h3>{{ recept.naam }}</h3>
      <p>{{ recept.categorie }}</p>
      <span class="categorie">{{ recept.categorie }}</span>
    </a>
  {% endfor %}
</div>