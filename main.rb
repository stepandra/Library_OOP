# frozen_string_literal: true

require_relative 'models/library.rb'

library = Library.new

File.exist?('data.yml') ? library.import : library.generate

puts "The most popular book: #{library.popular_book}"
puts "The most active reader: #{library.popular_reader}"
puts "Number of people, who ordered one of the 3 most popular \
books: #{library.readers_favourite}"
