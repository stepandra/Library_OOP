# frozen_string_literal: true

require 'faker'
require 'yaml'

require_relative 'author.rb'
require_relative 'book.rb'
require_relative 'order.rb'
require_relative 'reader.rb'
require_relative 'data_generator.rb'

# Class that simulates library
class Library
  include DataGenerator

  def self.export(element, file = 'data.yml')
    File.new(file, 'w') unless File.exist?(file)
    File.open(file, 'w') do |data|
      data.write(element.to_yaml)
    end
  end

  attr_accessor :books, :orders, :readers, :authors

  def initialize(books = [], orders = [], readers = [], authors = [])
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  def import(file = 'data.yml')
    data = YAML.load_file(file)
    @books = data.books
    @orders = data.orders
    @readers = data.readers
    @authors = data.authors
  end

  def generate
    generate_authors
    generate_books
    generate_readers
    generate_orders
    self.class.export(self)
  end

  def popular_book
    popular(1, :book).title
  end

  def popular_reader
    popular(1, :reader).name
  end

  def readers_favourite
    popular(3, :book) do |books|
      @orders.flat_map { |order| order.reader if books.include?(order.book) }
             .compact.uniq.size
    end
  end

  private

  def popular(number, method)
    result = @orders.group_by(&method)
                    .max_by(number) { |_, item| item.size }
                    .to_h.keys
    if !block_given?
      number == 1 ? result.first : result
    else
      yield result
    end
  end
end
