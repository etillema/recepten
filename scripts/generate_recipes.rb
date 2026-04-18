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

  # Front matter
  front_matter = {
    'layout' => 'recept',
    'naam' => recept['naam'],
    'categorie' => recept['categorie'],
    'bereidingstijd' => recept['bereidingstijd'],
    'personen' => recept['personen'],
    'ingredienten' => recept['ingredienten'],
    'stappen' => recept['stappen'],
    'notities' => recept['notities']
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
