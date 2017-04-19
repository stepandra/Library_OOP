# frozen_string_literal: true

# Author model
class Author
  attr_accessor :name, :biography

  def initialize(name, biography)
    @name = name
    @biography = biography
  end

  def to_s
    "#{name}: \n biography: #{biography}"
  end
end
