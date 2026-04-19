#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

# Laad recepten uit losse YAML-bestanden
recepten_dir_path = File.join(__dir__, '..', '_data', 'recepten')
recepten = Dir.glob(File.join(recepten_dir_path, '*.yml')).map { |f| YAML.load_file(f) }

# Maak _recepten map aan
recepten_dir = File.join(__dir__, '..', '_recepten')
FileUtils.mkdir_p(recepten_dir)

# Genereer Markdown met YAML front matter voor elk recept
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

  # Schrijf Markdown bestand met YAML front matter
  filepath = File.join(recepten_dir, "#{slug}.md")
  File.open(filepath, 'w') do |f|
    yaml_str = front_matter.to_yaml
    yaml_str = yaml_str.sub(/^---\n/, '') # Verwijder eerste --- van to_yaml
    f.write("---\n")
    f.write(yaml_str)
    f.write("---\n")
  end

  puts "✓ Generated: #{filepath}"
end

puts "\nKlaar! #{recepten.length} recepten gegenereerd."
