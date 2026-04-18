#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# Laad categorieën uit YAML
categorieën_file = File.join(__dir__, '..', '_data', 'categories.yml')
recepten_file = File.join(__dir__, '..', '_data', 'recepten.yml')

categorieën = YAML.load_file(categorieën_file)
recepten = YAML.load_file(recepten_file)

# Maak categorie map aan
categorie_dir = File.join(__dir__, '..', '_categorie')
FileUtils.mkdir_p(categorie_dir)

# Genereer pagina voor elke categorie
categorieën.each do |categorie|
  naam = categorie['naam']
  slug = categorie['slug']

  # Tel recepten in deze categorie
  count = recepten.count { |r| r['categorie'] == naam }

  # Front matter
  front_matter = {
    'layout' => 'categorie',
    'categorie_naam' => naam,
    'categorie_count' => count,
    'permalink' => "/categorie/#{slug}/"
  }

  # Schrijf Markdown bestand
  filepath = File.join(categorie_dir, "#{slug}.md")
  File.open(filepath, 'w') do |f|
    f.write(front_matter.to_yaml)
    f.write("---\n")
  end

  puts "✓ Generated: #{filepath} (#{count} recepten)"
end

puts "\nKlaar! #{categorieën.length} categorie-pagina's gegenereerd."
