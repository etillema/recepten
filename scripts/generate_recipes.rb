#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# Laad recepten uit YAML
recepten_file = File.join(__dir__, '..', '_data', 'recepten.yml')
recepten = YAML.load_file(recepten_file)

# Maak _recepten map aan
recepten_dir = File.join(__dir__, '..', '_recepten')
FileUtils.mkdir_p(recepten_dir)

# Genereer Markdown voor elk recept
recepten.each do |recept|
  naam = recept['naam']
  slug = naam.downcase.gsub(/\s+/, '-').gsub(/[^\w-]/, '')

  # Front matter met alle velden
  front_matter = {
    'layout' => 'recept',
    'naam' => recept['naam'],
    'categorie' => recept['categorie'],
    'keuken' => recept['keuken'],
    'bereidingstijd' => recept['bereidingstijd'],
    'wachttijd' => recept['wachttijd'],
    'oventemperatuur' => recept['oventemperatuur'],
    'oventijd' => recept['oventijd'],
    'personen' => recept['personen'],
    'ingredienten' => recept['ingredienten'],
    'stappen' => recept['stappen'],
    'tips' => recept['tips'],
    'tags' => recept['tags']
  }

  # Schrijf Markdown bestand
  filepath = File.join(recepten_dir, "#{slug}.md")
  File.open(filepath, 'w') do |f|
    f.write(front_matter.to_yaml)
    f.write("---\n")
  end

  puts "✓ Generated: #{filepath}"
end

puts "\nKlaar! #{recepten.length} recepten gegenereerd."
