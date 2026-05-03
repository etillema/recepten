serve: generate
	bundle exec jekyll serve --config _config.yml,_config_dev.yml

build: generate
	bundle exec jekyll build

generate:
	ruby scripts/generate_categories.rb
	ruby scripts/generate_recipes.rb

clean:
	bundle exec jekyll clean

build-verbose:
	bundle exec jekyll build --verbose

install:
	bundle config set --local path vendor/bundle
	bundle install
