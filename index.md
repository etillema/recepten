---
title: Beproefd!!
---

<h1 class="hero-title">Beproefd!!</h1>

<div class="categorieën-grid">
  {% for categorie in site.data.categories %}
    {% assign count = 0 %}
    {% for recept_pair in site.data.recepten %}
      {% assign recept = recept_pair[1] %}
      {% if recept.categorie == categorie.naam %}
        {% assign count = count | plus: 1 %}
      {% endif %}
    {% endfor %}
    
    <a href="{{ categorie.slug | prepend: '/categorie/' | append: '/' | relative_url }}" class="categorie-card" style="background-color: {{ categorie.kleur }}">
      <h3>{{ categorie.naam }}</h3>
      <p>{{ count }} recepten</p>
    </a>
  {% endfor %}
</div>