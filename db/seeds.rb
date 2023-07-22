# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# rubocop:disable Rails/Output
puts '###############',
     'Seeding started'

require_relative 'seeds/users'
require_relative 'seeds/categories'
require_relative 'seeds/bulletins'

puts 'Seeding stopped',
     '###############'
# rubocop:enable Rails/Output
