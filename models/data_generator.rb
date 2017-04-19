# frozen_string_literal: true

# Generator mixin
module DataGenerator
  def generate_authors
    @authors = []
    6.times do
      @authors << Author.new(
        Faker::Book.unique.author,
        Faker::Lorem.sentence(1)
      )
    end
  end

  def generate_books
    @books = []
    9.times do
      @books << Book.new(
        Faker::Book.unique.title,
        @authors.sample
      )
    end
  end

  def generate_readers
    @readers = []
    rand(7..14).times do
      @readers << Reader.new(
        Faker::Name.unique.name,
        Faker::Internet.unique.email,
        Faker::Address.city,
        Faker::Address.street_name,
        Faker::Address.building_number
      )
    end
  end

  def generate_orders
    @orders = []
    rand(10..28).times do
      @orders << Order.new(
        @books.sample,
        @readers.sample,
        Faker::Date.forward(7).strftime('%m/%d/%y')
      )
    end
  end
end
